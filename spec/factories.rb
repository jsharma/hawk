# This will guess the Hawker class
FactoryGirl.define do
  factory :hawker, :class => Hawk::Hawker do
    url "http://systango.com"
  end
end
