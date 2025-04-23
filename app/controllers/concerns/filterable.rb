module Filterable
  extend ActiveSupport::Concern
  include Pagy::Backend

  def filter_and_paginate
    @q = PostQuery.new.resolve(query_params)
    @pagy, @posts = pagy(PostQuery.new.resolve(query_params), items: 10)
  end
end