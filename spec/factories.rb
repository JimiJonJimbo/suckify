FactoryGirl.define do
  factory :post do
    link 'http://www.example.com'
    title 'This site sucks'
    description 'It\'s just an example'
    association :user, factory: :user
  end

  factory :user do
    username 'walt'
    login 'walt'
    email 'walt@meth.com'
    password 'jesseisstupid'
  end
end
