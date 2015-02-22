# Создадим записи в базе данных для проверки, 
# восклицательный знак после create стоит для вызова исключения в случае ошибки создания записи.
Card.create!([
  { original_text: "Привет. Как дела?", 
    translated_text: "Hello. How are you?", 
    review_date: Date.current },

  { original_text: "Откуда ты?", 
    translated_text: "where are you from?", 
    review_date: Date.yesterday },

  { original_text: "Привет. Как дела?", 
    translated_text: "Hello. How are you?", 
    review_date: Date.new(2015, 02, 12) }
  ])
