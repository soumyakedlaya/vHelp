class Donation < ActiveRecord::Base
  belongs_to :charity_rep
  belongs_to :donor
end
