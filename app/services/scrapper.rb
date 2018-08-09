require 'open-uri'
require 'nokogiri'

class Scrapper
attr_accessor :currency_name, :currency_price
  def initialize
    @crypto = []
    @currency_name = []
    @currency_price = []
  end

  def name
    p '============ + Début du Scrapping des noms + ============'
    #Création d'un array qui recevra les nom des crypto

    #On ouvre la page et on selection les elements de classe ".currency-name-container"
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")).css(".currency-name-container").each do |item|
    #Pour chacun d'entre eux, on prend la valeur texte
    var = item.text
    #On l'ajoute dans l'array créer plus haut
    @currency_name << var
    end
  end

  def price
    p '============ + Début du Scrapping des prix + ============'
    #Création d'un array qui recevra les prix des crypto

    #On ouvre la page et on selection les elements de classe ".price"
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")).css(".price").each do |item|
    #Pour chacun d'entre eux, on prend la valeur texte
    var = item.text
    #On l'ajoute dans l'array créer plus haut
    currency_price << var
    end
    p '============ + Création du Hash + ============'
    @crypto = Hash[@currency_name.zip(@currency_price)]

    p '============ + Création du Hash - TERMINÉ  + ============'
    #p @crypto
  end

  def save
    p '============ + Enregistrement - Début  + ============'
    @crypto.each do |k, v|
      c = Crypto.create(
        name: k,
        price: v
      )
      p 'c :'
      p c
    end
      p '============ + Enregistrement - Fin  + ============'
  end

  def update
    name
    price
    p '============ + Mise à jour - Début  + ============'
    x = 1
    @crypto.each do |k,v|
      c = Crypto.find(x).update(name: k, price: v)
      x += 1
      p c
    end
    p '============ + Mise à jour - Fin  + ============'
    return @crypto
  end

  def perform
    p name
    p price
    p save
    p '============ + Scrapping Accompli ! + ============'
    return @crypto
  end
end
