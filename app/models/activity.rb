class Activity < ApplicationRecord
  belongs_to :calculation

  self.inheritance_column = :type

  def calculate_emission!
    raise NotImplementedError, "#{self.class}#calculate_emission! não implementado"
  end
end
