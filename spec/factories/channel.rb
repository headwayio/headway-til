FactoryGirl.define do
  factory :channel do
    trait :development do
      development true
    end

    trait :design do
      design true
    end

    sequence(:name) { |n| "Channel #{n}" }
    sequence(:twitter_hashtag) { |n| "twitter-hashtag-#{n}" }

    transient do
      include_icon false
    end

    before(:create) do |channel, evaluator|
      if evaluator.include_icon
        channel.icon = Rails.root.join('spec/factories/files/sketch-icon.png').open
      end
    end
  end
end
