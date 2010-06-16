# RedmineBounceReport
module RedmineTurnaroundReport
  TIME_SQL = "(#{Issue.table_name}.updated_on - #{Issue.table_name}.created_on)"

  module Issue
    def time_open
      @time_open || begin
        time_elapsed =  (self.updated_on - self.created_on).round
        #find the minutes
        minutes = (time_elapsed / 60) % 60
        #find the hours
        hours = (time_elapsed/3600) % 24

        days = (time_elapsed/3600/24)
        #format the time
        @time_open = "#{days}d#{hours}h#{minutes}m"
      end
    end
  end
end