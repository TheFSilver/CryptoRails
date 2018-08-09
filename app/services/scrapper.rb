require 'open-uri'
require 'nokogiri'

class Scrapper

  def initialize
    @crypto = {}
  end

  def cryptomonnaies
    p '============ + Début du Scrapping des noms + ============'
    #Création d'un array qui recevra les nom des crypto
    currency_name = []
    #On ouvre la page et on selection les elements de classe ".currency-name-container"
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")).css(".currency-name-container").each do |item|
    #Pour chacun d'entre eux, on prend la valeur texte
    var = item.text
    #On l'ajoute dans l'array créer plus haut
    currency_name << var
    end
    p '============ + Début du Scrapping des prix + ============'
    #Création d'un array qui recevra les prix des crypto
    currency_price = []
    #On ouvre la page et on selection les elements de classe ".price"
    page = Nokogiri::HTML(open("https://coinmarketcap.com/all/views/all/")).css(".price").each do |item|
    #Pour chacun d'entre eux, on prend la valeur texte
    var = item.text
    #On l'ajoute dans l'array créer plus haut
    currency_price << var
    end
    p '============ + Création du Hash + ============'
    @crypto = Hash[currency_name.zip(currency_price)]

    p '============ + Création du Hash - TERMINÉ  + ============'
    #p @crypto
    p '============ + Enregistrement - Début  + ============'
    @crypto.each do |k, v|
      c = Crypto.create(
        name: k,
        price: v
      )
      p c
    end
      p '============ + Enregistrement - Fin  + ============'
  end

  def perform
    p cryptomonnaies
    p '============ + Scrapping Accompli ! + ============'
  end
end
