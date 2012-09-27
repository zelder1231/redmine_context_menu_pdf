require 'context_menus_helper'

class IssuesCtxtMenuPdfHelperHook < Redmine::Hook::ViewListener
  include ContextMenusHelper

  # * :issues
  # * :can
  # * :back
  def view_issues_context_menu_end(context={})
	
   ret_str=''
   ret_str << "<li>#{context_menu_link("#{l(:fullpdf)}", {:controller => 'context_menu_pdf', :action => 'print_pdf', :outputType => 'full', :issues => context[:issues], :report => '0', :back_url => context[:back]}, :class => 'icon icon-file application-pdf')}</li>"
   ret_str << "<li>#{context_menu_link("#{l(:Report)}", {:controller => 'context_menu_pdf', :action => 'print_pdf', :outputType => 'full', :issues => context[:issues], :report => '1', :back_url => context[:back]}, :class => 'icon icon-file application-pdf')}</li>"

  return ret_str

  end
end