class CardDummy
  attr_accessor :interval, :e_factor, :repetition_count, :review_date

  def set_items(interval: 0, e_factor: 2.5,
                repetition_count:0, review_date: DateTime.current)
    @interval = interval
    @e_factor = e_factor
    @repetition_count = repetition_count
    @review_date = review_date
  end
end
