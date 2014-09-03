class Category < ActiveRecord::Base

  before_validation :generate_slug
  validates :name, presence: true, uniqueness: true

  has_many :tags, dependent: :destroy
  has_many :projects, through: :tags

  def generate_slug
    self.slug ||= name.parameterize if name
  end

  def to_param
   name.parameterize
  end

end
