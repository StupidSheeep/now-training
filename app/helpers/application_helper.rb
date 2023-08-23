module ApplicationHelper

  def formatted_time(time)
    "#{time.strftime('%d/%m/%y(%a) %H:%M:%S')}"
  end

end
