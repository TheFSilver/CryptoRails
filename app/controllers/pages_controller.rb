class PagesController < ApplicationController
  def home
      @cryptos = Crypto.all
  end

  def scrapper
    Scrapper.new.perform
  end
end
