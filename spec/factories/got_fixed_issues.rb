# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :got_fixed_issue, :class => 'Issue' do
    title "MyString"
    closed false
  end
end
