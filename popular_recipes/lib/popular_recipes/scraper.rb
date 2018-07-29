require 'pry'
class PopularRecipes::RecipeScraper

  def get_page(url)
    Nokogiri::HTML(open(url))
  end

  def scrape_list_page
    doc = get_page("https://www.foodnetwork.com/recipes/photos/foodnetwork-top-50-most-saved-recipes")
    list_element = doc.css('section.o-PhotoGalleryPromo__m-AssetData.m-AssetData.asset-info')
    recipes = []
    list_element.each do |card|
      recipes << {
        :name => card.css('h3 span').text.gsub(/No\.\s[0-9]*:\s/, ""),
        :url => card.css('p a').attribute('href').value.gsub(/\A/, "https:")
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
