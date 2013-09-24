# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :got_fixed_user, :class => 'GotFixed::User' do
    email "foo@bar.com"
  end
end
