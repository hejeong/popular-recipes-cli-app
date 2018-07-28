class PopularRecipes::CLI
  def call
    puts
    puts
    puts "Welcome to Top 50 Popular Recipes!"
    puts "The recipes will be listed 10 at a time, and you'll be given the option to learn more about the recipe."
    puts "Which recipes would you like to see? (1-10) (11-20) (21-30) (31-40) (41-50)"
    list_input = gets.strip
    list_recipes(list_input)
    input = nil
    while input != 'exit'
      input = gets.strip
      if input.length > 0 && input.length <= 2 && input.match("[0-9]+")
        get_info(input)
      else
        list_recipes(input)
      end
    end
  end

  def get_info(number)
    number = number.to_i
    if number == 1
      puts "-----------------------------------------------------------------------------------------------------------------------------------------------------"
      puts "Ina's Lemon Chicken Breasts"
      puts "Servings: 4"
      puts "Level: Easy"
      puts "Total time: 1hr"
      puts "   Prep - 15 min"
      puts "   Inactive - 10 min"
      puts "   Cook - 35 min"
      puts "Ingredients: 1/4 cup good olive oil || 3 tablespoons minced garlic (9 cloves) || 1/3 cup dry white wine || 1 tablespoon grated lemon zest (2 lemons)"
      puts "    2 tablespoons freshly squeezed lemon juice || 1 1/2 teaspoons dried oregano || 1 teaspoon minced fresh thyme leaves"
      puts "    Kosher salt and freshly ground black pepper || 4 boneless chicken breasts, skin on (6 to 8 ounces each) || 1 lemon"
      puts "-----------------------------------------------------------------------------------------------------------------------------------------------------"
    elsif number == 2
    end
    puts "If you want to see another list, enter the range (1-10) (11-20) (21-30) (31-40) (41-50)"
    puts "To quit, type exit."
  end

  def list_recipes(list_input)
    case list_input
    when "1-10"
      puts
      puts
      puts
      puts "----------------------Recipes 1-10---------------------------"
      puts "1. Ina's Lemon Chicken Breasts"
      puts "2. Giada's Chicken Piccata"
      puts "3. Ina's Linguine with Shrimp Scampi"
      puts "-------------------------------------------------------------"
    when "11-20"
      puts
      puts
      puts
      puts "----------------------Recipes 11-20--------------------------"
      puts "11. Ina's Lemon Chicken Breasts"
      puts "12. Giada's Chicken Piccata"
      puts "13. Ina's Linguine with Shrimp Scampi"
      puts "-------------------------------------------------------------"
    when "21-30"
    when "31-40"
    when "41-50"
    else
    end
    puts "If you want to learn more about a recipe, enter the corresponding number."
    puts "Otherwise, if you want to see another list, enter the range (1-10) (11-20) (21-30) (31-40) (41-50)"
    puts "To quit, type exit."
  end
end
