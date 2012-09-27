class ContextMenuPdfController < ApplicationController
  include Redmine::Export::PDF
  helper :queries
  include QueriesHelper
  helper :sort
  include SortHelper
  include IssuesHelper
  helper :custom_fields
  include CustomFieldsHelper
 

  unloadable

  before_filter :setup_environment

	def print_pdf
		return unless @issues && @issues.size > 0

		@project=@issues[0].project
		             	
		retrieve_query
		sort_init(@query.sort_criteria.empty? ? [['id', 'desc']] : @query.sort_criteria)
    		sort_update(@query.sortable_columns)

		if @query.valid?
      		    @limit = Setting.issues_export_limit.to_i
		end

 		@issue_count = @query.issue_count
   		  @issue_pages = Paginator.new self, @issue_count, @limit, params['page']
   		  @offset ||= @issue_pages.current.offset

              if @issues.size == 1
                 (params[:report] == '1') ? send_data(issue_to_report_dispatch(@issues.first), :type => 'application/pdf', :filename => "#{@project.identifier}-#{@issues.first.id}.pdf") : send_data(issue_to_pdf(@issues.first), :type => 'application/pdf', :filename => "#{@project.identifier}-#{@issues.first.id}.pdf")
           	else
                 (params[:report] == '1') ? send_data(issues_to_dispatch(@issues, @project, @query), :type => 'application/pdf', :filename => 'export.pdf') : send_data(issues_to_pdf_dispatch(@issues, @project, @query), :type => 'application/pdf', :filename => 'export.pdf')    
	    	end

		return
	end

private
	def setup_environment
		unless params[:issues].blank?
			@issues=Issue.find_all_by_id(params[:issues])
		else
			@issues=nil
			redirect_back_or_default({:controller => 'issues', :action => 'index', :project_id => params[:project_id]})
		end
	end
end

