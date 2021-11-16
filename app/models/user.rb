class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
         :recoverable, :rememberable, :validatable

  extend FriendlyId
  friendly_id :username, use: :slugged
  def to_s
    email
  end

  def username
    self.email.split(/@/).first
  end

  def online?
    updated_at > 2.minutes.ago
  end
end
