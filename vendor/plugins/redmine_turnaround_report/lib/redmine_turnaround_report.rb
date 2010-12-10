# RedmineBounceReport
module RedmineTurnaroundReport
  BOUNCE_STATUS = 'Resolved'
  JOURNAL_DETAIL_CONDITION = " #{JournalDetail.table_name}.`prop_key` = 'status_id'  AND #{JournalDetail.table_name}.`value` = (SELECT id FROM #{IssueStatus.table_name} WHERE name = '#{BOUNCE_STATUS}')"
  TIME_SQL =  "(UNIX_TIMESTAMP(( " +
                "SELECT #{Journal.table_name}.created_on " +
                "FROM #{JournalDetail.table_name}, #{Journal.table_name} " +
                "WHERE #{JournalDetail.table_name}.journal_id = #{Journal.table_name}.id " +
                "  AND #{Journal.table_name}.journalized_type = 'Issue' " +
                "  AND #{JOURNAL_DETAIL_CONDITION} " +
                "  AND #{Journal.table_name}.journalized_id = #{Issue.table_name}.id " +
                "ORDER BY #{Journal.table_name}.created_on DESC LIMIT 1 " +
                ")) - UNIX_TIMESTAMP(#{Issue.table_name}.created_on))"

  module Issue
    def time_open
      @time_open || begin
        last_journal = self.journals.all(:include => :details, :conditions => RedmineTurnaroundReport::JOURNAL_DETAIL_CONDITION, :order => 'created_on DESC', :limit => 1 ).first
        if last_journal
          time_elapsed =  (last_journal.created_on - self.created_on).round
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
end
