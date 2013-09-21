require_dependency "got_fixed/application_controller"

module GotFixed
  class IssuesController < ApplicationController
    # before_action :set_issue, only: [:destroy]

    respond_to :json, :only => :github_webhook

    # GET /issues
    def index
      @issues = Issue.all
    end

    def github_webhook
      # TODO(ssaunier): json payload as "action" set to opened, closed or repoend
      #                 figure out how to get it (conflict with rails action param...)
      @issue = Issue.find_or_initialize_by :vendor_id => params[:issue][:id], :vendor => "github"
      @issue.title = params[:issue][:title]
      @issue.closed = params[:issue][:state] == "closed"
      @issue.save
      render :json => @issue
    end

    # # POST /issues
    # def create
    #   @issue = Issue.new(issue_params)

    #   if @issue.save
    #     redirect_to @issue, notice: 'Issue was successfully created.'
    #   else
    #     respond_with @issue
    #   end
    # end

    # # PATCH/PUT /issues/1
    # def update
    #   if @issue.update(issue_params)
    #     redirect_to @issue, notice: 'Issue was successfully updated.'
    #   else
    #     render action: 'edit'
    #   end
    # end

    # # DELETE /issues/1
    # def destroy
    #   @issue.destroy
    #   redirect_to issues_url, notice: 'Issue was successfully destroyed.'
    # end

    # private
    #   # Use callbacks to share common setup or constraints between actions.
    #   def set_issue
    #     @issue = Issue.find(params[:id])
    #   end

    #   # Only allow a trusted parameter "white list" through.
    #   def issue_params
    #     params.require(:issue).permit(:title, :closed)
    #   end
  end
end
