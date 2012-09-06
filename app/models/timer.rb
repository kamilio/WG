class Timer
  def self.time
    difference = Time.now - Unit.last.created_at
    if difference < 10.minutes.to_i
      return 3.minutes
    elsif difference < 1.hour.to_i
      return 10.minutes
    else 
      return 20.minutes
    end
  end  

  def self.wait
     p "Sleeping for #{time}"
     sleep rand time
  end
end
