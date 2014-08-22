class Project < ActiveRecord::Base

  validates :name, :pledging_ends_on, presence: true
  validates :description, length: { minimum: 5 }
  validates :target_pledge_amount, numericality: {
  	 greater_than: 0
  }
  validates :website, url: true

  has_many :pledges, dependent: :destroy

  def expired?
  	pledging_ends_on < Time.now
  end

  def self.pledging
    where('pledging_ends_on > ?', Time.now).order(pledging_ends_on: :asc)
  end

  def pledge_amount_sum
    pledges.sum(:amount)
  end

  def pledge_percentage
     (pledge_amount_sum / target_pledge_amount) * 100
  end

  def success?
    pledge_percentage >= 100
  end

end
