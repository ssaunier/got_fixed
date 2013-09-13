require_dependency "got_fixed/application_controller"

module GotFixed
  class IssuesController < ApplicationController
    # before_action :set_issue, only: [:destroy]

    # GET /issues
    def index
      @issues = Issue.all
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
