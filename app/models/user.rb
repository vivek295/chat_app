class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :username,presence: true,null: false, uniqueness: { case_sensitive: false }
  enum role: [:admin, :user]
  has_many  :posts
  has_many :subscriptions
  has_many :notifications
  has_many :friends, through: :subscriptions
  has_many :inverse_subscriptions, class_name: 'Subscription', foreign_key: :friend_id
  has_many :inverse_friends, through: :inverse_subscriptions, source: :user
end
