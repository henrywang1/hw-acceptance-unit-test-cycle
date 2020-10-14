FactoryBot.define do
    factory :movie do
        title {"Frozen"}
        rating {'PG'}
        release_date { 5.years.ago }
    end
end