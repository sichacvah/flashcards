# encoding: utf-8
require "open-uri"
require "nokogiri"


class WordsDownloader
  def initialize(url, original_text_col = 2, translated_text_col = 3)
    @url = url
    @original_text_col = original_text_col
    @translated_text_col = translated_text_col
  end

  def get_words(&closure)
    get_rows if @rows == nil
    words = []
    closure = lambda { |row| return row.css("td") } || lambda { closure }
    @rows.each do |row|
      cols = closure.call(row)
      words << [cols[@original_text_col].text, cols[@translated_text_col].text]
    end
    words
  end

  def get_rows(&closure)
    doc = Nokogiri::HTML(open(@url))
    closure = lambda { return doc.css("table.topwords").css("tr")[1..-1] } || lambda { closure }
    @rows = closure.call
  end
end

class CardCreator < WordsDownloader
  def create
    words = get_words
    words.each do |original_text, translated_text|
      Card.create!({ original_text: original_text,
                     translated_text: translated_text })
    end
  end
end

Card.delete_all
URL = "http://masterrussian.com/vocabulary/most_common_words.htm"
cards_creator = CardCreator.new(URL)
cards_creator.create
puts "created #{Card.count} cards"

