# == Schema Information
#
# Table name: photos
#
#  id             :bigint           not null, primary key
#  caption        :text
#  comments_count :integer
#  image          :string
#  likes_count    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  owner_id       :bigint           not null
#
# Indexes
#
#  index_photos_on_owner_id  (owner_id)
#
# Foreign Keys
#
#  fk_rails_...  (owner_id => users.id)
#
class Photo < ApplicationRecord
  belongs_to :owner, class_name: "User"
  has_many :comments
  has_many :likes
  has_many :fans, through: :likes

  validates :caption, presence: true
  validates :image, presence: true

  scope :by_likes, -> { order(likes_count: :desc) }
  scope :past_week, -> { where(created_at: 1.week.ago...) }

  def fan_list
    @_fan_list ||= fans.pluck(:username).to_sentence
  end
end
