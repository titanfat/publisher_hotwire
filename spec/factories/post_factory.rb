FactoryBot.define do
  factory :post do
    title { FFaker::Book.title }
    original_title { FFaker::Game.title }
    date_publishing { Date.today - 1.day }

    before(:create) do |post|
      unless post.authors.any? && !!post.publishable_type
        authors = create_list(:user, 3)
        post.publishable = create(:chapter)
        post.authors << authors
      end
    end
  end
end