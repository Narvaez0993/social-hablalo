class PostsController < ApplicationController
  before_action :set_post, only: %i[ show update destroy ]

  # GET /posts
  def index
    @posts = Post.order('created_at desc')
    @users = User.where(user_id: :user_id)
    @comments = Comment.where(post_id: :post_id).count
    puts @comments
    render :json => @posts.to_json({
      :only=>[:id,:title,:content,:user_id,:created_at],
      :include=>{:user => {:only => [:id,:email,:name]},:comments => {:only => [:id]}}
    })
  end

  # GET /posts/1
  def show
    @ejemplo = Post.where(id:params["id"])
    @comments = Comment.where(post_id:params["id"])
    @users = User.where(user_id: :user_id)
    @userComments = User.includes(:comments).where(id: 1)
    puts @userComments
    render :json => @ejemplo.to_json({ 
      :only=>[:id, :title, :content, :user_id, :created_at],
      :include=>{:user => {:only =>[:id,:name]},:comments => {:only => [:id,:title,:content,:user_id,:created_at]}}
    })
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render json: @post, status: :created, location: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render json: @post
    else
      render json: @post.errors, status: :unprocessable_entity
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
  end
 
  # get
  def allPost
    @posts = Post.joins(:comments)
    render json: @posts
  end
 

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :content, :user_id)
    end
end
