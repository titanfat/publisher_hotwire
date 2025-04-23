class ApplicationQuery
  ALLOW_COLUMN = [].freeze
  include Pagy::Backend

  private attr_reader :relation
  def initialize(relation) = @relation = relation

  def resolve(params) = raise NotImplementedError

  private def search(relation, query = nil)
    # return relation if query.blank?

    # q = "%#{ActiveRecord::Base.sanitize_sql_like(query)}%"

    # TODO: implements search posts by authors
    # authors_match = relation.model.joins(:authors).where(
    #   "users.first_name ilike :q or users.second_name ilike :q or users.last_name ilike :q", q: q
    # )

    # conditions = self.class::ALLOW_COLUMN.map {
    #   relation.model.arel_table[_1.to_sym].matches(q)
    # }.reduce(&:or)
    #
    #
    # relation.where(conditions)
  end
end
