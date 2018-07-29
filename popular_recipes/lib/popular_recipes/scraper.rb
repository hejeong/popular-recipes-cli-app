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
        :name => card.css('h3 span').text,
        :url => card.css('p a').attribute('href').value
      }
    end
    recipes
  end

  # return array of hashes
  def scrape_receipe_page(url)

  end
end
