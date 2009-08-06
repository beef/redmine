ActionController::Routing::Routes.draw do |map|
  map.show_task_board 'versions/task_board/:id', :controller => 'task_boards', :action => 'show'
  map.show_task_board_version 'versions/task_board/:id/:version_id', :controller => 'task_boards', :action => 'show'
end