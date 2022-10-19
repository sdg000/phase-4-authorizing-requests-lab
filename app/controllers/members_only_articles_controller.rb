class MembersOnlyArticlesController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  #before any action in this controller renders, it witl check user login using #authorize
  #if user not logged in, it will render error, else continue with requested User Action.
  before_action :authorize

  # returns all members_only articles for only logged_in users , arrange in order
  def index
    articles = Article.where(is_member_only: true).includes(:user).order(created_at: :desc)
    render json: articles, each_serializer: ArticleListSerializer
  end

  # find specific members_only article for only logged_in users
  def show
    article = Article.find(params[:id])
    render json: article
  end

  private

  def record_not_found
    render json: { error: "Article not found" }, status: :not_found
  end

  #action for returning error if user is not logged in
  def authorize
    return render json: { error: "Not authorized" }, status: :unauthorized unless session.include? :user_id
  end

end
