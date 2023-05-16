class User < ApplicationRecord
  has_many :attendances
  has_many :events, through: :attendances


  validates :first_name, presence: true, length: { minimum: 3, maximum: 140 }
  validates :last_name, presence: true, length: { minimum: 3, maximum: 140 }
  validates :description, presence: true, length: { minimum: 20, maximum: 1000 }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :encrypted_password, presence: true
  
  after_create :welcome_send

  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end
end
