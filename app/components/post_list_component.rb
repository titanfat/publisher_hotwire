# frozen_string_literal: true

class PostListComponent < ViewComponent::Base
  with_collection_parameter :post
  def initialize(post:) = @post = post
end
