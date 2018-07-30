class PopularRecipes::Recipe
  # <-- class variable
  @@all = []

  # attribute accessors
  attr_accessor :name, :url, :total_time, :yield, :author, :rating, :ingredients, :directions

  # <-- constructors
  def initialize(attribute_hash)
    attribute_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
    self.save
  end

  # attribute_hash is an array of hashes that contain the attributes + values of a recipe
  def self.create(array_of_hashes)
    array_of_hashes.each do |recipe|
      PopularRecipes::Recipe.new(recipe)
    end
  end


  # <--instance methods

  # add any additional attributes to an existing instance
  def add_attributes(attribute_hash)
    attribute_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end

  # save to class variable
  def save
    @@all << self
  end

  # return array of all instances of this class
  def self.all
    @@all
  end
end
