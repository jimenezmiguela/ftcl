class Bill < ApplicationRecord

  belongs_to :user

  validates_associated :user

  validates_presence_of :measure
  validates_presence_of :subject
  validates_presence_of :author
  validates_presence_of :status
  validates_presence_of :user_id
end
