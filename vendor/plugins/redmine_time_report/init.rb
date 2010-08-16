require 'redmine'


require 'dispatcher'
Dispatcher.to_prepare do
  Query.available_columns << QueryColumn.new(:spent_hours, :sortable => RedmineTimeReport::TIME_SQL, :default_order => 'desc')
end

Redmine::Plugin.register :bounce do
  name 'Redmine Time Report Plugin'
  author 'Steve England'
  description 'Allows the use of "spent_hours" in normal reports'
  version '0.0.1'
end
