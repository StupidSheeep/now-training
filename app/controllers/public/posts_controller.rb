class Public::PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index,:show,:search_results]
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @genres = Genre.all
    @user = User.all
    if params[:genre_id].present?
      @selected_genre = Genre.find(params[:genre_id])
      @post = @selected_genre.posts
    else
      @post = Post.all.order(created_at: :desc)
    end
    @post = @post.page(params[:page]).per(5) # ページネーションの追加
  end


  def show
    @post = Post.find(params[:id])
    @post_comment = Comment.new
  end

  def new
    @post = Post.new
    @genres = Genre.all
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to post_path(@post), notice: "投稿が完了しました！"
    else
      @posts = Post.all
      render 'new'
    end

  end

  def edit
    @post = Post.find(params[:id])
    @genres = Genre.all
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post), notice: "内容を更新しました。"
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.destroy
      redirect_to users_my_page_path(current_user), notice: "投稿を削除しました。"
    else
      redirect_to post_path(@post), alert: "投稿の削除に失敗しました。"
    end
  end

  def search_results
    @genres = Genre.all
    if params[:search].present?
      search_term = params[:search]
      @search_results = Post.where("#{params[:search_target]} LIKE ?", "%#{search_term}%")

      if params[:search_genre].present?
        @search_results = @search_results.where(genre_id: params[:search_genre])
      end
    else
      @search_results = []
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :target_time, :level, :genre_id)
  end

  def is_matching_login_user
    @post = Post.find(params[:id])
    unless @post.user == current_user
      redirect_to post_path(@post), alert: "他のユーザーの投稿は編集できません。"
    end
  end


end
