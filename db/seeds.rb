# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

kevin = User.new(name: 'Kevin', email: 'verre.kevin@gmail.com', password: 'helloworld', password_confirmation: 'helloworld')
#kevin.skip_confirmation!
kevin.save

puts "Kevin created."

user2 = User.new(
  name: 'Kevin Network',
  email: 'thekevinnetwork@gmail.com',
  password: 'helloworld',
  password_confirmation: 'helloworld')
#user2.skip_confirmation!
user2.save



puts "Kevin Network created."

#root = Post.create(ptype: FOLDER_TYPE, title: "Kevin's KevLinks Page", body: "My first attempt at making a KevLinks page.")
root = kevin.root
root.update(ptype: FOLDER_TYPE, title: "Kevin's FolderNotes Page", body: "My first attempt at making a FolderNotes page.")

puts "verre.kevin's root updated."

puts "Does user2 (kevinnetwork)'s root have siblings?: " + (user2.root.has_siblings?).to_s
user2.root.siblings.each do |s|
  puts "Sibling: " + s.title
end

topicA = Post.create(parent: root, user: kevin, ptype: FOLDER_TYPE, title: "Notes on Mac OSX", body: "", private: false)
topicB = Post.create(parent: root, user: kevin, ptype: FOLDER_TYPE, title: "Websites", body: "Websites and the Internet", private: false)
topicC = Post.create(parent: root, user: kevin, ptype: FOLDER_TYPE, title: "iPhone", body: "iPhone and iOS notes", private: false)
postC = Post.create(parent: topicC, user: kevin, ptype: BLOG_TYPE, title: "Swell Radio", body: "Swell is like Pandora radio but for podcasts instead of music.")
postC2 = Post.create(parent: topicC, user: kevin, ptype: BLOG_TYPE, title: "Coffee Meets Bagel", body: "CMB is a really simple Dating App. It matches you with one new person a day. It uses your Facebook to try to match you with friends of friends.", private: false)
postA = Post.create(parent: topicA, user: kevin, ptype: TWEET_TYPE, title: "Dropbox", body: "Automatically save every version of your files to the cloud.", private: false)
postA2 = Post.create(parent: topicA, user: kevin, ptype: BLOG_TYPE, title: "Evernote", body: "Evernote sucks, but it's still the best note taking software available on computers today.", private: false)
postB = Post.create(parent: topicB, user: kevin, ptype: LINK_TYPE, title: "Medium.com - well designed blogging platform", body: "http://www.medium.com", private: false)
postB2 = Post.create(parent: topicB, user: kevin, ptype: LINK_TYPE, title: "GetWorkDoneMusic.com - Techno music. Better than Pandora for getting work done.", body: "http://www.GetWorkDoneMusic.com", private: false)

puts "Posts created."

puts "Seed file finished"