module ApplicationHelper
  def format_date(date)
    if date.present?
      date.strftime('%m/%d/%Y')
    else
      ''
    end
  end
end
