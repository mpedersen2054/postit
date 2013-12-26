class PostsController < ApplicationController
  # before_action to set up var, or redirect based on condition
  # rails 3 was before_filter, rails 4 is before_action
  before_action :set_post, only: [:show, :edit, :update, :vote]
  before_action :require_user, except: [:show, :index, :vote]

  def index
    @posts = Post.all.sort_by{|x| x.total_votes}.reverse
  end

  def show
    @comment = Comment.new
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.creator = current_user

    if @post.save
      flash[:notice] = "This Post was Created"
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      flash[:notice] = "This Post was Updated"
      redirect_to post_path(@post)
    else
      render :edit
    end
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def vote
    @vote = Vote.create(voteable: @post, creator: current_user, vote: params[:vote])

    respond_to do |format|

      format.html do
        if @vote.valid?
          flash[:notice] = "Your vote was counted"
        else
          flash[:error] = "You can only vote on the post once"
        end
        redirect_to :back
      end

      format.js

    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, category_ids: [])
  end
end













