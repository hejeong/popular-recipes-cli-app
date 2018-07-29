require 'pry'
class PopularRecipes::RecipeScraper

  def get_page(url)
    Nokogiri::HTML(open(url))
  end

  def scrape_list_page
    doc = get_page("https://www.foodnetwork.com/recipes/photos/foodnetwork-top-50-most-saved-recipes")
    # No. 50 - name : doc.css('span.o-PhotoGalleryPromo__a-HeadlineText').text
    # url: doc.css('p.o-PhotoGalleryPromo__a-Cta a').attribute('href').value
  end

  # return array of hashes
  def scrape_receipe_page(url)
    doc = get_page("//www.foodnetwork.com/recipes/ina-garten/asian-grilled-salmon-recipe-1944413")
  end
end
