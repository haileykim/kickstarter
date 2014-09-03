class Project < ActiveRecord::Base

  has_many :pledges, dependent: :destroy
  has_many :backers, through: :pledges, source: :user

  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user

  has_many :tags, dependent: :destroy
  has_many :categories, through: :tags 

  belongs_to :user

  has_attached_file :image

  before_validation :generate_slug
  
  validates :name, presence: true, uniqueness: true
  validates :slug, uniqueness: true
  validates :pledging_ends_on, presence: true
  validates :description, length: { minimum: 5 }
  validates :target_pledge_amount, numericality: {
     greater_than: 0
  }
  validates_attachment :image, 
  :content_type => { :content_type => ['image/jpeg', 'image/png'] },
  :size => { :less_than => 1.megabyte }

  
  scope :pledging, -> { where('pledging_ends_on > ?', Time.now) }

  scope :recent, ->(max=4) { pledging.order(created_at: :desc).limit(max) }
  
  scope :endsoon, ->(max=4) { pledging.order(pledging_ends_on: :asc).limit(max)  }

  def expired?
  	pledging_ends_on < Time.now
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

  def generate_slug
    self.slug ||= name.parameterize if name
  end

  def to_param
    slug
  end
end
