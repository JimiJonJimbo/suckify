FactoryGirl.define do
  factory :post do
    link "http://www.example.com"
    title "This site sucks"
    description "It's just an example"
  end

  factory :user do
    username "walt"
    email "walt@meth.com"
    password "jesseisstupid"
  end
end