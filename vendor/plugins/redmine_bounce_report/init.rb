require 'redmine'


require 'dispatcher'
Dispatcher.to_prepare do
  Query.available_columns << QueryColumn.new(:bounces, :sortable => RedmineBounceReport::BOUNCE_SQL, :default_order => 'desc')
  Issue.send :include, RedmineBounceReport::Issue
end

Redmine::Plugin.register :bounce do
  name 'Redmine Bounce Count Plugin'
  author 'Steve England'
  description 'Counts how many times a ticket has been boundces to status feedback'
  version '0.0.1'
end
