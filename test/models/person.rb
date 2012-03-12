class Person < ActiveRecord::Base
  model_stamper
  # overwritten
  def stamper_name 
    "Stamper name: #{name}"
  end
end