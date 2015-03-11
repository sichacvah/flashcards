class SuperMemo
  def initialize(options = {}, quality)
    @quality = quality
    @interval = options[:interval]
    @e_factor = options[:e_factor]
    @quality = options[:quality]
    @repetition_count = options[:repetition_count]
    if @quality < 3
      restart_repetition
  end


  def get_repetition
    set_new_interval
    if @repetition_count > 1
      modify_e_factor
    { interval: @interval,
      e_factor: @e_factor,
      repetition_count: @repetition_count + 1 }
  end

  private

  def restart_repetition
    @repetition_count = 0
  end

  def set_new_interval
    if @repetition_count == 0
      1
    elsif @repetition_count == 1
      6
    else
      @interval * @e_factor
    end
  end

  def modify_e_factor
    @e_factor += 0.1 - (5 - @quality) * (0.08 + (5 - @quality) * 0.02)
    @e_factor = 1.3 if @e_factor < 1.3
  end


end