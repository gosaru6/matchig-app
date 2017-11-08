module ApplicationHelper
  def simple_time(time)
    time.strftime("%Y-%m-%d　")
  end

  def cut_off(text, len)
    if text != nil
      if text.length < len
        text
      else
        text.scan(/^.{#{len}}/m)[0] + "…"
      end
    else
      ''
    end
  end
end
