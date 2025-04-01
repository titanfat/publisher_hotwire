FactoryBot.define do
  factory :chapter do
    publisher { FFaker::Company.name }
    isbn { FFaker::IdentificationMX.rfc }
    page_count { rand(10..100) }
  end
end