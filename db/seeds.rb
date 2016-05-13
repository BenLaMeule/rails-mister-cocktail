# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'open-uri'
require 'nokogiri'

Dose.destroy_all
Ingredient.destroy_all
Cocktail.destroy_all

for i in 1..7 do
  url = "http://www.barmano.fr/drinks/ingredient/search?page=#{i}&query=keyword:"
  html_file = open(url)
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search('.itemName a').each do |element|
    Ingredient.create(name: element.content)
  end
end

for i in 1..5 do
  url = "http://www.barmano.fr/drinks/recipe/search?page=#{i}&query=+recipeName:"
  html_file = open(url)
  html_doc = Nokogiri::HTML(html_file)
  html_doc.search('.item.hasTools').each do |element|
    image_url = element.search('.itemInfoContainer a img').attribute("src").value
    name = element.search('.itemInfoContainer a').attribute("title").value
    cocktail = Cocktail.create(name: name, image_url: image_url)
    element.search('.itemInfoContainer .itemInfo li a').each do |ingre|
      name = ingre.attribute("title").value if ingre.attribute("title")
      if Ingredient.find_by_name(name)
        ingredient = Ingredient.find_by_name(name)
      elsif name != ""
        ingredient = Ingredient.create(name: name)
      end
      Dose.create(description: "ingrédient issu du site 'barmano'", cocktail: cocktail, ingredient: ingredient)
    end
  end
end
