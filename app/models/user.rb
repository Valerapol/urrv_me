class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :trackable,
  :recoverable, :rememberable, :confirmable, :validatable

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

  rolify
  validate :must_have_a_role, on: :update

  after_create :assign_default_role

  def assign_default_role
    if User.count ==1
      self.add_role(:admin) if self.roles.blank?
      self.add_role(:staff)
      self.add_role(:instructor)
      self.add_role(:mentor)
      self.add_role(:atc)
      self.add_role(:guest_atc)
      self.add_role(:student)
      self.add_role(:trainee)
      self.add_role(:member)
    else
      self.add_role(:member) if self.roles.blank?
    end
  end
  private
  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "#{I18n.t(:role)}")
    end
  end
end
