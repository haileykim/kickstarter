class Pledge < ActiveRecord::Base
 
  validates :amount, numericality: { greater_than: 0 }

  belongs_to :project
  belongs_to :user

end
