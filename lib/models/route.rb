class Logistics::Route < ActiveRecord::Base
  belongs_to :map

  validates :source, :target, :distance, presence: true
  validates :distance, numericality: { greater_than: 0 }
  validate  :road

  def road
    errors.add(:source, "the source and target must be different") if source == target
  end
end
