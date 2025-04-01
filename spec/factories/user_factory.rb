FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { '0000' }
    first_name { FFaker::NameRU.first_name }
    last_name { FFaker::NameRU.last_name }
    second_name { FFaker::NameRU.middle_name_male }
    orcid { rand(10000..100_000_00) }

    trait :with_session do
      after(:create) do |user|
        create(:session, user: user)
      end
    end
  end
end

FactoryBot.define do
  factory :session do
    user
    user_agent { "test user" }
    ip_address { "127.0.0.1" }
  end
end
