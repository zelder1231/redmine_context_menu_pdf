if Rails::VERSION::MAJOR >= 3
  RedmineApp::Application.routes.draw do
    match 'context_menu_pdf/:action', :to => 'context_menu_pdf#print_pdf', :via => [:get, :post]
  end
else
  ActionController::Routing::Routes.draw do |map|
     map.connect 'context_menu_pdf/:action', :controller => 'context_menu_pdf'
  end
end
