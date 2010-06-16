require 'redmine'

require 'dispatcher'
Dispatcher.to_prepare do
  Query.available_columns << QueryColumn.new(:time_open, :sortable => RedmineTurnaroundReport::TIME_SQL, :default_order => 'desc')
  Issue.send :include, RedmineTurnaroundReport::Issue
end

Redmine::Plugin.register :turnaround do
  name 'Redmine Turnaround Plugin'
  author 'Steve England'
  description 'Checks how long the time is between the ticket being created and the last update'
  version '0.0.1'
end
