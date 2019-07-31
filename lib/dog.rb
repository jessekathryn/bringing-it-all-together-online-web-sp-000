class Dog 
  
attr_accessor :id, :name, :breed
  
  def initialize(id:nil, name:, breed:)
    @id = id
    @name = name
    @breed = breed
  end
  
  def self.new_from_db(row)
    
    id = row[0] 
    name = row[1] 
    breed = row[2] 
    
    new_dog = self.new(id: id, name: name, breed: breed)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS dogs (
     id INTEGER PRIMARY KEY,
     name TEXT,
     breed TEXT
     )
     SQL
     
     DB[:conn].execute(sql)
  end
  
  def self.drop_table
    sql = <<-SQL
    DROP TABLE dogs
    SQL
    
    DB[:conn].execute(sql)
  end
  
  def self.find_by_name(name)
    sql = <<-SQL
     SELECT * FROM dogs WHERE name = ?
     SQL
     
     DB[:conn].execute(self.name)
  end
  
  def self.find_by_id(id:)
    sql = <<-SQL
     SELECT * FROM dogs WHERE id = ?
     SQL
     
      DB[:conn].execute(sql, self.id:)
      
    end
    
  def self.find_or_create_by(name:, breed:)
    sql = <<-SQL
    SELECT * FROM dogs WHERE name = ? AND breed = ?
    SQL
    
    DB[:conn].execute(sql, self.name, self.breed)
  end
  
  def self.create(name)
    dog = Dog.new(name)
    dog.save
    dog
  end
  
  def self.update
    sql = <<-SQL
    UPDATE id WHERE name = ? AND breed = ?
    SQL
    
    DB[:conn].execute(sql, self.name, self.breed)
  end 
    
  def save
    sql = <<-SQL
      INSERT INTO dogs (name, breed)
      VALUES (?, ?)
    SQL
 
    id = DB[:conn].execute(sql, self.name, self.breed)
    result = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")
     Dog.new(id:result[0], name:result[1], breed:result[2])
  end
end 