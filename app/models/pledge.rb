class Pledge < ActiveRecord::Base
  validates :name, presence: true
  validates :amount, numericality: { greater_than: 0 }

  belongs_to :project

end
