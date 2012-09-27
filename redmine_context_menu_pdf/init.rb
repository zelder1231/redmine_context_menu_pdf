require 'redmine'

unless Redmine::Plugin.registered_plugins.keys.include?(:redmine_context_menu_pdf)
	Redmine::Plugin.register :redmine_context_menu_pdf do
	  name 'Context menu pdf plugin'
	  author 'Dagda'
	  author_url ''
	  description 'Plugin adds pdf export menu items to context menu'
	  version '0.0.1'

    requires_redmine :version_or_higher => '1.4.0'

	end

	require 'ctxt_menu_pdf_hooks'

end

