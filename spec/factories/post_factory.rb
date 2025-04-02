FactoryBot.define do
  factory :post do
    title { FFaker::Book.title }
    original_title { FFaker::Game.title }
    date_publishing { Date.today - 1.day }

    association :publishable, factory: :chapter

    before(:create) do |post|
      post.authors = create_list(:user, 3) if post.authors.blank?
    end

    after(:build) do |post|
      if post.publishable.is_a?(Chapter)
        post.publisher = post.publishable.publisher
        post.isbn = post.publishable.isbn
        post.page_count = post.publishable.page_count
      end
    end
  end
end