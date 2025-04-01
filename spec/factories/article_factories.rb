FactoryBot.define do
  factory :article do
    doi { FFaker::IdentificationMX.rfc }

    before(:create) do |article|
      unless !!article.journal
        journal = FactoryBot.create(:journal)
        article.journal = journal
      end
    end
  end
end