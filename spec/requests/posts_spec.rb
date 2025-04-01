require 'rails_helper'

RSpec.describe PostsController, type: :request do

  before(:all) do
    @user = User.create!(
      email: 'test@rspec.com', password: '123456', password_confirmation: '123456',
      first_name: 'Test', last_name: 'User', second_name: 'Rspec', orcid: 123_123_123
    )

    @journal = Journal.create!(title: "Test Journal")
    @article = Article.create!(doi: "12345", journal: @journal)

    @posts = 3.times.map do |i|
      Post.create!(
        title: "test title #{i}",
        original_title: "title #{i}",
        authors: [ @user ],
        date_publishing: Date.today - 1.days,
        publishable: @article
      )
    end

    get new_session_path(email: @user.email, password: @user.password, password_confirmation: @user.password)
  end

  after(:all) do
    @posts.each(&:destroy)
    @journal.destroy
    @user.destroy
    @article.destroy
  end


  describe 'index' do
    it '200 ok' do
      get posts_path
      byebug
      expect(response).to have_http_status(:ok)
    end

    it 'posts with pagination' do
      get posts_path, params: { page: 1 }
      expect(assigns(@posts).size).to be <= Pagy::DEFAULT[:items]
    end

    it 'posts search by title' do
      post = @posts.first
      get posts_path, params: { search_column: 'title', keyword: post.title }
      expect(assigns(@posts)).to include(post)
    end

    it 'sort by title' do
      get posts_path, params: { sort_scope: 'by_title', order: 'asc' }
      expect(assigns(@posts)).to eq(@posts.sort_by(&:title))
    end
  end


  describe 'create' do
    context 'post create with parameters' do
      it 'with valid' do
        expect {
          post posts_path, params: { post: attributes_for(@posts, authors: [@user], title: "Test post",
                                                          original_title: "title",
                                                          authors: [ @user ],
                                                          date_publishing: Date.today - 1.days,
                                                          publishable: @article) }
        }.to change(Post, :count).by(1)
      end
    end

    context 'with invalid' do
      it 'not to be created' do
        expect {
          post posts_path, params: { post: attributes_for(:post, title: nil) }
        }.not_to change(Post, :count)
      end
    end
  end


  describe 'estroy' do
    it 'delete post' do
      post = @posts.first
      expect {
        delete post_path(post)
      }.to change(Post, :count).by(-1)
    end
  end

  #
  # describe 'Auth' do
  #   it 'redirect' do
  #     get posts_path
  #     expect(response).to redirect_to(new_user_session_path)
  #   end
  # end
end