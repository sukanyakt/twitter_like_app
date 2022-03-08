class User < ApplicationRecord
  acts_as_token_authenticatable

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tweets, dependent: :destroy
  
  has_many :follows, dependent: :destroy

  has_many :follower_relationships, foreign_key: :following_id, class_name: "Follow"
  has_many :followers, through: :follower_relationships, source: :follower

  has_many :following_relationships, foreign_key: :user_id, class_name: "Follow"
  has_many :following, through: :following_relationships, source: :following

  has_many :phone_numbers, dependent: :destroy

  scope :get_followees_ids, ->(user_id) { User.find_by_id(user_id).try(:following).pluck(:id) }
         
end
