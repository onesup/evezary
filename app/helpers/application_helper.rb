module ApplicationHelper
  def time_iterate(start_time, end_time, step, &block)
    begin
      yield(start_time)
    end while (start_time += step) <= end_time
  end
end
