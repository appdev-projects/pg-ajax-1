desc "Fill the database tables with some sample data"
task sample_data: :environment do
  starting = Time.now

  FollowRequest.delete_all
  Comment.delete_all
  Like.delete_all
  Photo.delete_all
  User.delete_all

  people = Array.new(10) do
    {
      first_name: Faker::Name.first_name,
      last_name: Faker::Name.last_name,
    }
  end

  people << { first_name: "Alice", last_name: "Smith" }
  people << { first_name: "Bob", last_name: "Smith" }
  people << { first_name: "Carol", last_name: "Smith" }
  people << { first_name: "Doug", last_name: "Smith" }

  people.each do |person|
    username = person.fetch(:first_name).downcase

    user = User.create(
      email: "#{username}@example.com",
      password: "password",
      username: username.downcase,
      name: "#{person[:first_name]} #{person[:last_name]}",
      bio: Faker::Lorem.paragraph(
        sentence_count: 2,
        supplemental: true,
        random_sentences_to_add: 4
      ),
      website: Faker::Internet.url,
      private: [true, false].sample,
      avatar_image: "https://robohash.org/#{username}"
    )

    p user.errors.full_messages
  end

  users = User.all

  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.75
        first_user_follow_request = first_user.sent_follow_requests.create(
          recipient: second_user,
          status: FollowRequest.statuses.values.sample
        )

        p first_user_follow_request.errors.full_messages
      end

      if rand < 0.75
        second_user_follow_request = second_user.sent_follow_requests.create(
          recipient: first_user,
          status: FollowRequest.statuses.values.sample
        )

        p second_user_follow_request.errors.full_messages
      end
    end
  end

  users.each do |user|
    rand(15).times do
      photo = user.own_photos.create(
        caption: Faker::Quote.jack_handey,
        image: "/#{rand(1..10)}.jpeg"
      )

      p photo.errors.full_messages

      user.followers.each do |follower|
        if rand < 0.5
          photo.fans << follower
        end

        if rand < 0.25
          comment = photo.comments.create(
            body: Faker::Quote.jack_handey,
            author: follower
          )

          p comment.errors.full_messages
        end
      end
    end
  end

  # Make sure alice doesn't follow bob, bob is private, and bob is in alice's discover
  alice = User.find_by(username: "alice")
  bob = User.find_by(username: "bob")
  bob.update(private: true)
  follow_request = FollowRequest.find_by(sender: alice, recipient: bob)
  follow_request.destroy
  photo = bob.own_photos.first
  photo.fans << alice.leaders.first

  ending = Time.now
  p "It took #{(ending - starting).to_i} seconds to create sample data."
  p "There are now #{User.count} users."
  p "There are now #{FollowRequest.count} follow requests."
  p "There are now #{Photo.count} photos."
  p "There are now #{Like.count} likes."
  p "There are now #{Comment.count} comments."
end
