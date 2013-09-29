# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :got_fixed_user, :class => 'GotFixed::User' do
    sequence :email do |n|
      "email#{n}@factory.com"
    end
  end
end
