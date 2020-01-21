require('pg')

class Property

  attr_accessor :address, :value, :number_of_bedrooms, :build
  attr_reader :id

  def initialize(options)
    @address = options['address']
    @value = options['value'].to_i
    @number_of_bedrooms = options['number_of_bedrooms'].to_i
    @build = options['build']
    @id = options['id'].to_i if options['id']
  end

  def save()
    db=PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "INSERT INTO properties (address, value, number_of_bedrooms, build)
    VALUES ($1, $2, $3, $4) RETURNING *"
    values = [@address, @value, @number_of_bedrooms, @build]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def Property.all()
    db=PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties"
    db.prepare("all", sql)
    houses=db.exec_prepared("all")
    db.close()
    return houses.map{|house| Property.new(house)}
  end

  def Property.delete_all()
    db=PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "DELETE FROM properties"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end


  def delete()
    db=PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "DELETE FROM properties WHERE id = $1"
    values = [@id]
    db.prepare("delete_1", sql)
    db.exec_prepared("delete_1", values)
    db.close()
  end

  def update()
    db=PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "UPDATE properties
    SET (address, value, number_of_bedrooms, build) = ($1, $2, $3, $4)
    WHERE id = $5"
    values=[@address, @value, @number_of_bedrooms, @build, @id]
    db.prepare('update', sql)
    db.exec_prepared('update', values)
    db.close()
  end

  def Property.find(id)
    db=PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE id = $1"
    values = [id]
    db.prepare('find', sql)
    found = db.exec_prepared('find', values)
    db.close
    return found.map{|house| Property.new(house)}
  end

  def Property.find_by_address(address)
    db=PG.connect({dbname: 'property_tracker', host: 'localhost'})
    sql = "SELECT * FROM properties WHERE address = $1" #sets a variable for receiving the
    values = [address]
    db.prepare('find_by_address', sql)
    found = db.exec_prepared('find_by_address', values)
    db.close
    return found.map{|house| Property.new(house)}
  end

end
