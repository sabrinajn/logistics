class Logistics::SearchParamsValidator
  include ActiveModel::Validations

  attr_accessor :name, :source, :target, :price, :autonomy

  validates :name, :source, :target, :price, :autonomy, presence: true
  validates :price, :autonomy, numericality: { greater_than: 0 }

  def initialize(attributes = {})
    attributes.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end
end
