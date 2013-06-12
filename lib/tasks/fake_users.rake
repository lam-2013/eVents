#SAMPLE DATA RAKE
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_locals
    make_posts
    #make_photos
    make_relationships
    make_private_messages
  end
end

def make_users
  admin = User.create!(name: "Elisabetta",
                       email: "elisabetta.gallione@libero.it",
                       password: "betta88",
                       password_confirmation: "betta88",
                       category: "festaiolo")
  admin.toggle!(:admin)
  99.times do |n|
    name  = Faker::Name.name
    # take users from the Rails Tutorial book since most of them have a "real" profile pic
    email = "example-#{n+1}@railstutorial.org"
    password  = "password"
    category = "festaiolo"
    User.create!(name: name,
                 email: email,
                 password: password,
                 password_confirmation: password,
                 category: "festaiolo")
  end
end


def make_posts
  # generate 50 fake posts for the first 10 users
  users = User.all(limit: 10)
  50.times do
    post_content = Faker::Lorem.sentence(8)
    users.each { |user| user.posts.create!(content: post_content )}
  end
end

def make_photos
  # generate fake photos
  users = User.all
  2.times do
    users.each{ |user| user.photos.create!( content: File.open(Dir.glob(File.join(Rails.root,
                                          'foto_eVents', '*')).sample)); }
  end
end

def make_locals
  9.times do |n|
    name  = Faker::Name.name
    Local.create!(name: name)
  end

end

def make_users_follow_locals
  local = Local.all
  users = User.all
  user =  users.first
  local.each { |followed| user.follow_local!(followed)}
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..50]
  followers = users[3..40]
  # first user follows user 3 up to 51
  followed_users.each { |followed| user.follow!(followed) }
  # users 4 up to 41 follow back the first user
  followers.each { |follower| follower.follow!(user) }
end

def make_private_messages
  # generate 10 fake messages for the first user
  first_user = User.first
  users = User.all
  message_from_users = users[3..12]
  message_from_users.each do |user|
    msg_body = Faker::Lorem.sentence(8)
    msg_subject = Faker::Lorem.sentence(3)
    message = Message.new
    message.sender = user
    message.recipient = first_user
    message.subject = msg_subject
    message.body = msg_body
    message.save!
  end
end



