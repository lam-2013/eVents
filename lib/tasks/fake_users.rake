#SAMPLE DATA RAKE
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_locals
    make_events
    make_posts
    make_photos
    make_relationships
    make_users_follow_locals
    make_partecipa_events
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
  19.times do |n|
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
  10.times do
    post_content = Faker::Lorem.sentence(8)
    users.each { |user| user.posts.create!(content: post_content )}
  end
end

def make_photos
  # generate fake photos
  users = User.all
  5.times do
    users.each{ |user| user.photos.create!( content: (Dir.glob(File.join(Rails.root,
                                          'app/assets/foto_eVents', '*')).sample)); }
  end
end

def make_locals
  5.times do |n|
    name  = Faker::Name.name
    Local.create!(name: name,
                  tipo: 'Nightclubbing')
  end

end

def make_events
  3.times do |n|
    name  = Faker::Name.name
    Event.create!(name: name,
                  tipo: 'Nightclubbing' )
  end
end

def make_partecipa_events
  events = Event.all
  event = events.first
  users = User.all
  users_fol_event =users[0..10]
  users_fol_event.each {|partecipante| partecipante.follow_event!(event)}
end

def make_users_follow_locals
  locals = Local.all
  local = locals.first
  users = User.all
  users_fol_local = users[0..10]
  users_fol_local.each { |follower| follower.follow_local!(local) }
end

def make_relationships
  users = User.all
  user = users.first
  followed_users = users[2..10]
  followers = users[3..19]
  # first user follows user 3 up to 51
  followed_users.each { |followed| user.follow!(followed) }
  # users 4 up to 41 follow back the first user
  followers.each { |follower| follower.follow!(user) }
end

def make_private_messages
  # generate 10 fake messages for the first user
  first_user = User.first
  users = User.all
  message_from_users = users[3..7]
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



