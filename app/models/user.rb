# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class User < ActiveRecord::Base
  attr_accessible :email, :name, :password, :password_confirmation
  has_secure_password 

  has_many :microposts , dependent: :destroy #10.9 
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy  #11.4

  before_save { |user| user.email = email.downcase } #before saving to the db downcase the email address to help ensure uniqueness
  before_save :create_remember_token


  validates :name, presence: true, length: { maximum: 50 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, 
  			format: { with: VALID_EMAIL_REGEX }, 
  			uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: { minimum:6 }
  validates :password_confirmation, presence: true
  #end

  def feed
    Micropost.where("user_id = ?", id)    
  end

    #8.18
  private 
  
  def create_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

end
