# frozen_string_literal: true

class PostListComponent < ViewComponent::Base

  def initialize(posts:) = @posts = posts
end
