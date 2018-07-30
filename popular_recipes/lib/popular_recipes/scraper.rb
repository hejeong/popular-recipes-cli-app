require 'pry'
class PopularRecipes::RecipeScraper

  def get_page(url)
    Nokogiri::HTML(open(url))
  end

  def scrape_list_page
    doc = get_page("http://www.geniuskitchen.com/ideas/all-time-favorite-recipes-6365?c=24106")
    index_card = doc.css('div.smart-info div.smart-info-wrap')
    recipes = []
    index_card.each do |card|
      recipes << {
        :name => card.css('h2.title a').text.gsub(/#[0-9]*:\s/, ""),
        :url => card.css('h2.title a').attribute('href').value
      }
    end
    recipes
  end

  def scrape_recipe_page(url)
    doc = get_page("https://www.foodnetwork.com/recipes/ina-garten/asian-grilled-salmon-recipe-1944413")
    ingredients = []
    ingredient_wrapper = doc.css('div.o-Ingredients__m-Body ul li label')
    ingredient_wrapper.each do |element|
    ingredients << element.text
    end
    binding.pry
    {
      :total_time => doc.css('dd.o-RecipeInfo__a-Description-Total').first.text,
      :yield => doc.css('section.o-RecipeInfo.o-Yield dl dd').first.text.strip,
      :level => doc.css('section.o-RecipeInfo.o-Level dl dd').first.text.strip,
      :ingredients => ingredients
    }
  end
end
