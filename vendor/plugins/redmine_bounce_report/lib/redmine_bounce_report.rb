# RedmineBounceReport
module RedmineBounceReport
  BOUNCE_STATUS = 'Feedback'
  JOURNAL_DETAIL_CONDITION = " #{JournalDetail.table_name}.`prop_key` = 'status_id'  AND #{JournalDetail.table_name}.`value` = (SELECT id FROM #{IssueStatus.table_name} WHERE name = '#{BOUNCE_STATUS}')"
  BOUNCE_SQL =  "( " +
                "SELECT COUNT(#{Journal.table_name}.id) " +
                "FROM #{JournalDetail.table_name}, #{Journal.table_name} " +
                "WHERE #{JournalDetail.table_name}.journal_id = journals.id " +
                "  AND #{Journal.table_name}.journalized_type = 'Issue' " +
                "  AND #{JOURNAL_DETAIL_CONDITION} " +
                "  AND #{Journal.table_name}.journalized_id = #{Issue.table_name}.id " +
                "GROUP BY #{Journal.table_name}.journalized_id " +
                ") "

  module Issue
    def bounces
      @bounces ||= self.journals.count(:conditions => JOURNAL_DETAIL_CONDITION, :include => :details )
    end
  end
end