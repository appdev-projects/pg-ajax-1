# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  comments_count         :integer          default(0)
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  likes_count            :integer          default(0)
#  private                :boolean          default(TRUE)
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :accepted_received_follow_requests, -> { accepted }, class_name: "FollowRequest", foreign_key: :recipient_id
  has_many :accepted_sent_follow_requests, -> { accepted }, class_name: "FollowRequest", foreign_key: :sender_id
  has_many :comments, foreign_key: :author_id
  has_many :discover, through: :leaders, source: :liked_photos
  has_many :feed, through: :leaders, source: :own_photos
  has_many :followers, through: :accepted_received_follow_requests, source: :sender
  has_many :leaders, through: :accepted_sent_follow_requests, source: :recipient
  has_many :liked_photos, through: :likes, source: :photo
  has_many :likes, foreign_key: :fan_id
  has_many :own_photos, class_name: "Photo", foreign_key: :owner_id
  has_many :received_follow_requests, class_name: "FollowRequest", foreign_key: :recipient_id
  has_many :sent_follow_requests, class_name: "FollowRequest", foreign_key: :sender_id

  validates :username, presence: true, uniqueness: { case_sensitive: false }
end
