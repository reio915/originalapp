module TweetsHelper
  def convert_percent(number)
    if number.present?
      cal_percent = number / 5.to_f * 100
      percent = cal_percent.round
      return percent.to_s
    else
      return 0
    end
  end
  def getPercent(number)
    number.present? ? (number / 5.to_f * 100).round.to_s : "0"
  end
end
