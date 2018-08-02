require 'pry'
class PopularRecipes::CLI
  # calls all necessary methods for CLI to run
  def call
    create_recipes
    welcome
    #list_input = gets.strip
    #list_recipes(list_input)
    input = nil
    while input != 'exit'
      input = gets.strip
      if input.length > 0 && input.length <= 2 && input.match("[0-9]+") && input.to_i.between?(1,25)
        get_info(input)
      else
        list_recipes(input)
      end
    end
  end

  private

  # create recipe instances and all necessary attributes
  def create_recipes
    # grab name and url attributes
    new_attributes = PopularRecipes::RecipeScraper.scrape_list_page
    # create new instances of recipes and save them
    PopularRecipes::Recipe.create(new_attributes)
    # use the urls of each instance and scrape all the other information and update the attributes
    #PopularRecipes::Recipe.all.each do |recipe|
    #  additional_attr = scraper.scrape_recipe_page(recipe.url)
    #  recipe.add_attributes(additional_attr)
    #end
  end

  # display all information about a recipe
  def get_info(number)
    index = number.to_i - 1
    item = PopularRecipes::Recipe.all[index]
    if item.rating == nil
      additional_attr = PopularRecipes::RecipeScraper.scrape_recipe_page(item.url)
      item.add_attributes(additional_attr)
    end
    puts "-----------------------------------------------------------------------------------------------------------------------------------------------------"
      puts "[#{item.name}] by #{item.author}"
      puts "Servings: #{item.yield}   Total time: #{item.total_time}     Rating: #{item.rating}"
      puts "Ingredients:"
      item.ingredients.each do |ingredient|
        puts "  ~ #{ingredient}"
      end
      puts "Directions:"
      item.directions.each do |direct|
        puts "~ #{direct}"
      end
    puts "-----------------------------------------------------------------------------------------------------------------------------------------------------"
    puts "If you want to see another list, enter the range (1-5) (6-10) (11-15) (16-20) (21-25) To quit, type exit."
  end

  # output a numbered list of the recipe names
  def list_recipes(list_input)
    puts
    puts
    puts
    if list_input.length > 2 && list_input != "exit"
      case list_input
      when "1-5"
        list_range(0, list_input)
      when "6-10"
        list_range(5, list_input)
      when "11-15"
        list_range(10, list_input)
      when "16-20"
        list_range(15, list_input)
      when "21-25"
        list_range(20, list_input)
      else
        puts "Invalid input."
      end
    else
      puts "Invalid input."
    end
    puts "If you want to learn more about a recipe, enter the corresponding number."
    puts "Otherwise, if you want to see another list, enter the range (1-5) (6-10) (11-15) (16-20) (21-25)"
    puts "To quit, type exit."
  end

  def list_range(start, input)
    puts "----------------------Recipes #{input}---------------------------"
    recipes = PopularRecipes::Recipe.all
    recipe(start,recipes)
    puts "-------------------------------------------------------------"
  end

  # prints each recipe by name 5 at a time
  def recipe(start_index, array)
    5.times do
      puts "#{start_index + 1}. #{array[start_index].name}"
      start_index += 1
    end
  end

  # welcome message
  def welcome
    puts
    puts
    puts "Welcome to 25 Popular Recipes!"
    puts "The recipes will be listed 5 at a time, and you'll be given the option to learn more about the recipe."
    puts "Which recipes would you like to see? (1-5) (6-10) (11-15) (16-20) (21-25)"
  end
end
