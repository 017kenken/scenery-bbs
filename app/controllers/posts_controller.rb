class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :likes]
  before_action :set_place, only: [:new, :edit]
  before_action :authenticate_user!, only: [:likes]

  # GET /posts
  # GET /posts.json
  def index
    @q = Post.ransack(params[:q])
    @posts = @q.result(distinct: true)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @likers = @post.likers(User)
    if current_user
      @comment = Comment.new
      @comment.auther = current_user.name
    end
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.auther = current_user.name
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def likes
    @user = current_user  
    @user.toggle_like!(@post)
    if @user.likes?(@post)
        redirect_back(fallback_location: root_path, notice: "よき！しました")
    else
      redirect_back(fallback_location: root_path, notice: "よき！を解除しました")
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_place
      @places = Place.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content, :auther, :place, :user_id, images:[])
    end
end
