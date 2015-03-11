class SuperMemo
  def initialize(interval, e_factor, repetition_count, time_to_answer)
    @quality = set_quality time_to_answer
    @current_interval = interval
    @e_factor = e_factor
    @repetition_count = repetition_count
    reset if @quality < 3
  end

  def get_repetition
    interval = set_new_interval
    modify_e_factor if @repetition_count > 1
    {
      interval: interval,
      e_factor: @e_factor,
      repetition_count: @repetition_count + 1,
      review_date: DateTime.current + interval.days
    }
  end

  private

  def set_quality(time_to_answer)
    if time_to_answer.nil?
      return 0
    end
    case time_to_answer.to_i / 1000
    when 0..5   then 5
    when 6..10  then 4
    when 11..15 then 3
    when 16..20 then 2
    else
      1
    end
  end

  def reset
    @repetition_count = 0
  end

  def set_new_interval
    case @repetition_count
    when 0 then 1
    when 1 then 6
    else
      @current_interval * @e_factor
    end
  end

  def modify_e_factor
    # e_factor - easiness factor reflecting the easiness of memorizing.
    # From SuperMemo method by P.A.Wozniak http://www.supermemo.com/english/ol/sm2.htm
    @e_factor += 0.1 - (5 - @quality) * (0.08 + (5 - @quality) * 0.02)
    @e_factor = 1.3 if @e_factor < 1.3
  end
end
