FactoryBot.define do
  factory :report do
    conference_name { FFaker::Conference.name }
    conference_place { FFaker::Address.city }

    before(:create) do |report|
      unless !!report.reporter
        reporter = create(:user)
        report.reporter = reporter
      end
    end
  end
end
