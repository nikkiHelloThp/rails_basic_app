# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
City.destroy_all
puts "All Cities have been destroyed!"
Author.destroy_all
puts "All Authors have been destroyed!"
Tag.destroy_all
puts "All Tags have been destroyed!"
Gossip.destroy_all
puts "All Gossips have been destroyed!"
Comment.destroy_all
puts "All Comments have been destroyed!"
Like.destroy_all
puts "All Likes have been destroyed!"
Conversation.destroy_all
puts "All Conversations have been destroyed!"
PrivateMessage.destroy_all
puts "All PrivateMessages have been destroyed!"

5.times do
	city = City.create(
					 name: Faker::Address.city,
				 )
	puts "city #{city.name} created!"
end

5.times do
	author = Author.create(
					   f_name: Faker::Hipster.word,
					   l_name: Faker::Artist.name,
					   description: Faker::Lorem.sentence,
					   email: Faker::Internet.email,
					   age: rand(18..35),
					   password: "123456",
						 city_id: City.all.ids.sample
					 )
	puts "author #{author.l_name} created!"
end

5.times do
	tag = Tag.create(
					name: Faker::Verb.base
				)
	puts "tag #{tag.name} created!"
end

9.times do
	gossip = Gossip.create(
						 title: Faker::Lorem.word,
						 body: Faker::Lorem.sentence,
						 author_id: Author.all.ids.sample,
						 tag_id: Tag.all.ids.sample
					 )
	puts "gossip #{gossip.title} created!"
end

20.times do
	comment_gossip = Comment.create(
							body: Faker::Lorem.sentence,
							author_id: Author.all.ids.sample,
						  commentable_id: Gossip.all.ids.sample,
						  commentable_type: 'Gossip'
						)
	puts "comment_gossip #{comment_gossip.body} created!"
end

20.times do
	comment_comment = Comment.create(
							body: Faker::Lorem.sentence,
							author_id: Author.all.ids.sample,
						  commentable_id: Comment.all.ids.sample,
						  commentable_type: 'Comment'
						)
	puts "comment_comment #{comment_comment.body} created!"
end

5.times do |i|
	like = Like.create(
					 author_id: Author.all.ids.sample,
					 gossip_id: Gossip.all.ids.sample
				 )
	puts "like #{ i + 1} created!"
end

5.times do
	conversation = Conversation.create(
									 sender_id: Author.all.ids.sample,
									 recipient_id: Author.all.ids.sample
								 )
	puts "Conversation #{conversation.sender_id} created!"
end

50.times do
	private_message = PrivateMessage.create(
											body: Faker::Lorem.sentence,
											conversation_id: Conversation.all.ids.sample,
											author_id: Author.all.ids.sample
										)
	puts "private_message #{private_message.body} created!"
end