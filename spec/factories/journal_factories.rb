FactoryBot.define do
  factory :journal do
    title { FFaker::Book.title }
    issn { FFaker::IdentificationMX.rfc }
  end
end