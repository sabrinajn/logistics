class Logistics::MapParamsValidator
  include ActiveModel::Validations

  attr_accessor :name, :file

  validates :name, :file, presence: true
  validate :file_validation

  def initialize(attributes = {})
    attributes.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end

  private

   def file_validation
     errors.add(:file, "file is invalid") unless file.present? and File.file?(file[:tempfile])
   end
end
