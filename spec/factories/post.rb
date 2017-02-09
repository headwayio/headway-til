FactoryGirl.define do
  factory :post do
    title 'Web Development'
    body 'Today I learned about web development'
    developer
    published_at Time.current
  end

  trait :for_today do
    # noop
  end

  trait :for_yesterday do
    published_at Time.now - 1.day
  end

  trait :for_last_week do
    published_at Time.now - 1.week
  end

  trait :for_last_year do
    published_at Time.now - 1.year
  end

  trait :with_punctuated_title do
    title "It's Friday & Stuff"
  end

  trait :draft do
    published_at nil
  end
end
