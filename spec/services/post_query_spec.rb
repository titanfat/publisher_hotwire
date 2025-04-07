# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PostQuery  do
  describe '.order_by' do
    it 'calls by_title with asc order' do
      scoped = Post.all
      expect(scoped).to receive(:by_title).with('asc').and_return(scoped.sort_by(&:title))

      query = PostQuery.new
      query.send(:order_by, scoped, 'by_title', 'asc')
    end
  end
end