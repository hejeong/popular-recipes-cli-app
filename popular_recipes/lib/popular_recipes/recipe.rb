class PopularRecipes::Recipe
  @@all = []

  def initialize(attribute_hash)
    attribute_hash.each do |attribute, value|
      self.send("#{attribute}=", value)
    end
  end
  # attribute_hash is an array of hashes that contain the attributes + values of a recipe
  def self.create(array_of_hashes)
    array_of_hashes.each do |recipe|
      PopularRecipes::Recipe.new(recipe)
    end
  end

  def self.all
    @@all
  end
end