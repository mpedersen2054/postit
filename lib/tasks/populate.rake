namespace :db do
  desc "Erase and fill db"
  task populate: :environment do
    require 'populator'

    [User, Post, Category, Comment].each(&:delete_all)

    User.populate 10 do |person|
      person.username = Faker::Name.name
      person.created_at = 2.years.ago..Time.now
    end
  end
end

