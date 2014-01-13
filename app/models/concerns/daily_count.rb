module DailyCount
  extend ActiveSupport::Concern
  module ClassMethods
    def daily_count(day)
      start_date = day.beginning_of_day
      end_date = day.end_of_day
      count = self.where("created_at >= :start_date AND created_at <= :end_date",
        {start_date: start_date, end_date: end_date}).count
    end
  end
end