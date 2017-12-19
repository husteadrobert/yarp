Fabricator(:business) do
  name { Faker::Name.name }
  address { Faker::Address.street_address }
  phone_number { Faker::PhoneNumber.subscriber_number(10) }
end