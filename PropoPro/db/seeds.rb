# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
10.times do
  Proposal.create(
    user_id: 1,
    admin_id: 1,
    email: "tashapoint0h27@gmail.com",
    title: Faker::Lorem.word,
    budget: Faker::Number.between(1000, 27000),
    invoice_paid: Faker::Boolean.boolean,
    proposal_accepted: Faker::Boolean.boolean
  )

  User.create(:email => "tashapoint0h27@gmail.com")
  Admin.create(:email => "braydonwhitmarsh@me.com")
end
