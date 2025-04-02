require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let!(:user) { create(:user) }
  let!(:chapter) { create(:chapter) }
  let!(:posts) { create_list(:post, 3, publishable: chapter, authors: [user]) }

  before { post session_path, params: { email: user.email, password: user.password } }


  describe 'index' do
    it '200 ok' do
      get posts_path
      expect(response).to have_http_status(:ok)
      expect(posts.count).to eq(3)
    end

    # it 'posts with pagination' do
    #   get posts_path, params: { page: 1 }
    #   expect(assigns(posts).size).to be <= Pagy::DEFAULT[:items]
    # end

    it 'posts search by title' do
      post = posts.first
      get posts_path, params: { search_column: 'title', keyword: post.title }
      expect(posts).to include(post)
    end

    it 'sort by title' do
      get posts_path, params: { sort_scope: 'by_title', order: 'asc' }
      expect(posts).to eq(posts.sort_by(&:title))
    end
  end


  # describe 'create' do
  #   context 'post create with parameters' do
  #     it 'with valid' do
  #       expect {
  #         post posts_path, params: { post: attributes_for(posts, authors: [user], title: "Test post",
  #                                                         original_title: "title",
  #                                                         authors: [ user ],
  #                                                         date_publishing: Date.today - 1.days,
  #                                                         publishable: article) }
  #       }.to change(Post, :count).by(1)
  #     end
  #   end
  #
  #   context 'with invalid' do
  #     it 'not to be created' do
  #       expect {
  #         post posts_path, params: { post: attributes_for(:post, title: nil) }
  #       }.not_to change(Post, :count)
  #     end
  #   end
  # end


  # describe 'estroy' do
  #   it 'delete post' do
  #     post = @posts.first
  #     expect {
  #       delete post_path(post)
  #     }.to change(Post, :count).by(-1)
  #   end
  # end

  #
  # describe 'Auth' do
  #   it 'redirect' do
  #     get posts_path
  #     expect(response).to redirect_to(new_user_session_path)
  #   end
  # end
end