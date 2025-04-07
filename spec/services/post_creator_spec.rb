# frozen_string_literal: true

RSpec.describe Post::PostCreator do
  let!(:user) { create(:user) }

  describe 'call' do
    context 'with type chapter' do
      let(:post_parameters) do
        {
          post: { author_ids: [user.id.to_s], title: "Test post", original_title: "title",
                  date_publishing: Date.today - 1.days, isbn: 'test1234',
                  page_count: 22, publisher: 'test publisher', publishable_type: 'Chapter' }
        }
      end

      it 'created post' do
        expect { described_class.call(post_parameters) }.to change(Post, :count).by(1)
      end
    end
  end
end