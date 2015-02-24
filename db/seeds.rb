require "open-uri"
require "nokogiri"

Card.delete_all

URL = "http://masterrussian.com/vocabulary/most_common_words.htm"
ORIGINAL_COL = 2
TRANSLATED_COL = 3

document = Nokogiri::HTML(open(URL))
rows = document.css("table.topwords").css("tr")[1..-1]

rows.each do |row|
  cols = row.css("td")
  original_text = cols[ORIGINAL_COL].text
  translated_text = cols[TRANSLATED_COL].text
  Card.create! original_text: original_text, translated_text: translated_text
end

logger = Logger.new(STDOUT)
logger.info "created #{Card.count} cards"
