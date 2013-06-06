#SAMPLE DATA RAKE
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    User.create!(name: "Elisabetta",
                 email: "elisabetta.gallione@libero.it",
                 password: "pwd123",
                 password_confirmation: "pwd123")
    admin.toggle!(:admin)
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      # "!" in ruby fa modifiche vere e non temporanee
      #se l'inserimento non va a buon fine  genera avviso
      User.create!(name: name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end

    # generate 50 fake posts for the first 10 users
    users = User.all(limit: 10)
    50.times do
      post_content = Faker::Lorem.sentence(8)
      users.each { |user| user.posts.create!(content: post_content )}
    end

     #for foto
    #users = User.all
   # 50.times do
     # { |user| user.photos.create! (content: File.open(Dir.glob(File.join(Rails.root, 'sampleimages', '*')).sample)
  #user.save! }
  #end
  end
end
