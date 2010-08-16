module RedmineTimeReport
  TIME_SQL =  "( " +
                "SELECT SUM(#{TimeEntry.table_name}.hours) " +
                "FROM #{TimeEntry.table_name} " +
                "WHERE #{TimeEntry.table_name}.issue_id = #{Issue.table_name}.id " +
                ") "

end
