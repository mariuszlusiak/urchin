FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end

  sequence :name do |n|
    "User#{n} Name"
  end

  sequence :login do |n|
    "User#{n} Name"
  end

  sequence :sender do |n|
    "00888888#{n}"
  end

  sequence :response do |n|
    "112233445566#{n}"
  end

  sequence :mobile_number do |n|
    "0012345678#{n}"
  end

  sequence :package_name do |n|
    "Package_#{n}"
  end

  factory :user, :class => User do
    name { Factory.next(:name) }
    login { Factory.next(:login) }
    email { Factory.next(:email) }
    sender { Factory.next(:sender) }
    password '123456'
    password_confirmation '123456'
  end

  factory :package do
    name { Factory.next(:package_name) }
    description "Amazing package"
    day_limit 20
    amount 1000
    validity 30
  end

  factory :message, :class => Message do
    association :user
    text 'Massage Body....'
    sender "00222223333444"
    unit { rand(3)+1 } # 1,2 or 3.
    ascii true
  end

  factory :subscription do
    association :package
  end

  factory :recipient do
    #association :message
    mobile_number { Factory.next(:mobile_number) }
    response { Factory.next(:response) }
    sent_at { DateTime.now + 14.days }
  end

end
