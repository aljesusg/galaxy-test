FactoryGirl.define do
  factory :shift do
    day_of_week 1
    start_time "MyString"
    end_time "MyString"
    sites_reserved 1
    room nil
  end
end
