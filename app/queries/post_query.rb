class PostQuery < ApplicationQuery
  ALLOW_COLUMN = %w[title original_title publishable_type publisher doi isbn conference_name conference_place conference_place reporter_name].freeze
  def initialize(relation = Post.all)
    super(relation)
  end

  def resolve(params)
    scoped = relation.includes(:publishable)
    scoped = search(scoped, params[:search_column], params[:keyword])
    scoped = order_by(scoped, params[:sort_scope], params[:order])
  end

  private def order_by(scoped, scope, sort = :desc) = scope ? scoped.public_send(scope, sort) : scoped

end
