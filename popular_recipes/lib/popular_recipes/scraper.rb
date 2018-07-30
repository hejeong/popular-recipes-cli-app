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
    doc = get_page(url)
    ingredients = []
    ingredient_wrapper = doc.css('ul.ingredient-list li')
    ingredient_wrapper.each do |element|
      quantity = element.css('span.qty').text
      food = element.css('span.food').text
      text = quantity.ljust(7) + food.strip
      ingredients << text
    end

    directions = []
    directions_wrapper = doc.css('div.directions-inner.container-xs ol li')
    directions_wrapper.each do |element|
      directions << element.text
    end
    directions.pop
    {
      :author => doc.css('div.rating-and-author h6.byline a').first.text,
      :total_time => doc.css('table.recipe-facts.servings_unit tbody tr td.time').text.gsub(/\n/,"").gsub(/\s/,"").gsub(/READYIN:/,""),
      :yield => doc.css('td.servings a span').text,
      :rating => doc.css('div.five-star span.sr-only').text,
      :ingredients => ingredients,
      :directions => directions
    }
  end
end
