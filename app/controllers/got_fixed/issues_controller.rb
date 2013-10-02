require_dependency "got_fixed/application_controller"

module GotFixed
  class IssuesController < ApplicationController
    # before_action :set_issue, only: [:destroy]
    before_action :check_hub_signature!, :only => :github_webhook

    respond_to :json
    respond_to :js

    # GET /issues
    def index
      @issues = Issue.all
    end

    def github_webhook
      # TODO(ssaunier): json payload as "action" set to opened, closed or repoend
      #                 figure out how to get it (conflict with rails action param...)
      @issue = Issue.find_or_initialize_by :vendor_id => params[:issue][:id].to_s, :vendor => "github"
      @issue.title = params[:issue][:title]
      @issue.closed = params[:issue][:state] == "closed"
      @issue.save
      render :json => @issue
    end

    def subscribe
      @user = User.find_or_initialize_by :email => params[:user][:email]
      @issue = Issue.find params[:id]
      unless @issue.users.include?(@user)
        @issue.users << @user
        @issue.save
      end
    end

    private

      def check_hub_signature!
        owner, repo = params[:repository][:full_name].split("/")
        options = GotFixed.config[:github].find(:owner => owner, :repo => repo).first
        request.body.rewind
        request_body = request.body.read

        github_webhook = Receivers::GithubWebhook.new :secret => options[:webhook_secret]
        github_webhook.check_hub_signature! request.headers['X-Hub-Signature'], request_body
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
