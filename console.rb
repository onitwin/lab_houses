require('pry')
require_relative("models/property.rb")

Property.delete_all()

house1 = Property.new(
  {'address' => '123 Fake Street',
    'value' => '125000',
    'number_of_bedrooms' => '4',
    'build' => 'detached'
  }
)

house2 = Property.new(
  {'address' => '567 Real Street',
    'value' => '250000',
    'number_of_bedrooms' => '10',
    'build' => 'bungalow'
  }
)

house1.save()
house2.save()

house1.number_of_bedrooms = 8
house1.update

binding.pry
nil
