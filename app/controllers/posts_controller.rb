class PostsController < ApplicationController
  def index
    load_posts
    respond_to do |f|
      f.html
      f.turbo_stream
    end
  end

  def new
    @post = Post.new
  end

  def edit; end

  def create
    @post = Post::PostCreator.call(post_params)
    if @post.present?
      redirect_to posts_path, notice: "Публикация успешно создана!"
      turbo_stream
    else
      render posts_path
    end
  end

  def update
    if find_post.update(post_params)
      render post_path, status: :ok
    else
      render posts_path, status: :unprocessable_entity
    end
  end

  def destroy
    find_post
    @post.destroy
  end

  private

  def find_post
    @post ||= Post.find(params[:id])
  end

  def load_posts
    @pagy, @posts = pagy(PostQuery.new.resolve(query_params).includes(:publishable, :authors), items: 10)
  end

  def query_params
    params.permit(:search_column, :keyword, :sort_scope, :order, :format)
  end

  def post_params
    params.require(:post).permit(:title, :original_title, :publishable_type, :isbn, :page_count, :doi, :journal_id, :publisher, :isbn,
                                 :conference_name, :conference_place, :reporter_id, :date_publishing, author_ids: [])
  end
end
