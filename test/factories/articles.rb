FactoryGirl.define do
  factory :article do
    sequence(:title){|n|"Article#{n}"}
    body "Blah,Blah,Blah."
    release_at 2.weeks.ago
    expire_at 2.weeks.from_now
  end
end
