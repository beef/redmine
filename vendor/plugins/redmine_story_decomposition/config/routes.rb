ActionController::Routing::Routes.draw do |map|
  map.decompose_story 'issues/decompose/:id/:action', :controller => 'decompositions', :action => 'index'
end