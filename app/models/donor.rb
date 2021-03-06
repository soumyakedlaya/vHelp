class Donor < ActiveRecord::Base
  has_secure_password
  has_many :donations, dependent: :destroy
  has_many :charityReps, through: :donations

  before_validation do
    self.email = email.downcase if email.present?
  end

  email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :money_available, :presence => true
  validates :email, :presence => true, :format => { :with => email_regex }, :uniqueness => { :case_sensitive => false }
  validates :password, on: create, :presence => true
end
