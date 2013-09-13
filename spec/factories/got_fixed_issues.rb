# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :got_fixed_issue, :class => 'Issue' do
    title "A very bad issue..."
    closed false
    vendor_id "iWnj89"
    number 7
  end
end
