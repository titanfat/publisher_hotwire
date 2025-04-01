class Post < ApplicationRecord
  include ActiveModel::Attributes

  attribute :doi, :string
  attribute :journal_id, :integer
  attribute :publisher, :string
  attribute :isbn, :string
  attribute :page_count, :integer
  attribute :conference_name, :string
  attribute :conference_place, :string
  attribute :reporter_id, :integer
  attribute :reporter_name, :string

  after_initialize :set_publishable_attributes

  validates :title, :original_title, :authors, presence: true
  validates_with PostsCreatorValidator, on: :create

  has_and_belongs_to_many :authors, class_name: "User", join_table: "authors_posts"
  belongs_to :publishable, polymorphic: true

  has_one :self_ref, class_name: "Post", foreign_key: :id
  has_many :article, through: :self_ref, source: :publishable, source_type: "Article"
  has_many :chapter, through: :self_ref, source: :publishable, source_type: "Chapter"
  has_many :report, through: :self_ref, source: :publishable, source_type: "Report"

  scope :by_published, ->(sort = :desc) { order(date_publishing: sort) }
  scope :by_title, ->(sort = :asc) { order(title: sort) }
  scope :by_original_title, ->(sort = :asc) { order(original_title: sort) }

  private

  def set_publishable_attributes
    case publishable
    when Report
      self.conference_place = publishable.conference_place
      self.conference_name = publishable.conference_name
      self.reporter_id = publishable.reporter_id
      self.reporter_name = publishable.reporter&.first_name || "broken data"
    when Article
      self.doi = publishable.doi
      self.journal_id = publishable.journal_id
    when Chapter
      self.publisher = publishable.publisher
      self.isbn = publishable.isbn
      self.page_count = publishable.page_count
    end
  end
end
