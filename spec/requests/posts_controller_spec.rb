require 'rails_helper'

RSpec.describe PostsController, type: :request do
  let!(:user) { create(:user) }
  let!(:posts) { create_list(:post, 22, authors: [user]) }

  before { post session_path, params: { email: user.email, password: user.password } }


  describe 'index' do
    it '200 ok' do
      get posts_path
      expect(response).to have_http_status(:ok)
      expect(posts.count).to eq(22)
    end

    it 'posts search by title' do
      post = posts.first
      get posts_path, params: { search_column: 'title', keyword: post.title.first(3) }
      expect(posts).to include(post)
    end
  end


  describe 'create' do
    context 'post create with parameters' do
      let(:post_parameters) do
        { author_ids: [user.id.to_s], title: "Test post", original_title: "title",
                            date_publishing: Date.today - 1.days, isbn: 'test1234',
                            page_count: 22, publisher: 'test publisher', publishable_type: 'Chapter'
        }
      end

      it 'with valid' do
        expect { post posts_path, params: { post: attributes_for(:post).merge(post_parameters) } }
          .to change(Post, :count).by(1)
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


  describe 'destroy' do
    it 'delete post' do
      post = posts.first
      expect {
        delete post_path(post)
      }.to change(Post, :count).by(-1)
    end
  end
end