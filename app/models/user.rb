class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  attr_accessor :need_validate

  belongs_to :team
  belongs_to :position
  has_many :user_skills
  has_many :skills, through: :user_skills
  has_many :projects_users, dependent: :destroy
  has_many :projects, through: :projects_users

  validates :name,  presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 30},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, length: {minimum: 6}, if: :need_validate 
  
  has_secure_password
  
  before_save {self.email.downcase!}
  before_create :create_remember_token

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private
  def create_remember_token
    self.remember_token = User.encrypt User.new_remember_token
  end
end