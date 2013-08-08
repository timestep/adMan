# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :page do
    slug {Faker::Internet.domain_name}
    name {Faker::Name.name}
  end
end
