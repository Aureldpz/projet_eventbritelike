class Event < ApplicationRecord
  has_many :attendances
  has_many :users, through: :attendances


  validates :start_date, presence: true
  validates :start_date_cannot_be_in_the_past, on: [:create, :update]

  def start_date_cannot_be_in_the_past
    if start_date.present? && start_date < Time.zone.now
     errors.add(:start_date, "can't be in the past")
    end
  end
  
  validates :duration, presence: true, numericality: { only_integer: true, greater_than: 0, multiple_of: 5 }
  validates :title, presence: true, length: { minimum: 5, maximum: 140 }
  validates :description, presence: true, length: { minimum: 20, maximum: 1000 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 1000 }
  validates :location, presence: true
end
