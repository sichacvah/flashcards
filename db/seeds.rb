# encoding: utf-8
require "open-uri"
require "nokogiri"


class WordsDownloader
  def initialize(url, original_text_col = 2, translated_text_col = 3, table_selector = "table.topwords")
    @url = url
    @original_text_col = original_text_col
    @translated_text_col = translated_text_col
    @table_selector = table_selector
  end

  def get_words(&closure)
    get_rows if @rows == nil
    words = []
    closure = if closure.nil?
      lambda { |row| return row.css("td") }
    else
      # используется если требуемая информация находится не в табличной форме
      lambda { closure }
    end
    @rows.each do |row|
      cols = closure.call(row)
      words << [cols[@original_text_col].text, cols[@translated_text_col].text]
    end
    words
  end

  def get_rows(&closure)
    doc = Nokogiri::HTML(open(@url))
    closure = 
    if closure.nil?
      lambda { return doc.css(@table_selector).css("tr")[1..-1] }
    else
      # используется если требуемая информация находится не в табличной форме
      lambda { closure }
    end
    @rows = closure.call
  end
end

class CardCreator < WordsDownloader
  def create
    words = get_words
    words.each do |original_text, translated_text|
      Card.create!({ 
        original_text: original_text,
        translated_text: translated_text
        })
    end
  end
end


Card.delete_all

URL = "http://masterrussian.com/vocabulary/most_common_words.htm"

cards_creator = CardCreator.new(URL)
cards_creator.create

logger = Logger.new(STDOUT)
logger.info "created #{Card.count} cards"

