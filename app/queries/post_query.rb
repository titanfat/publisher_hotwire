class PostQuery < ApplicationQuery
  ALLOW_COLUMN = %w[title original_title].freeze
  def initialize(relation = Post)
    super(relation)
  end

  def resolve(params)
    scoped = relation.includes(:publishable, :authors)
    scoped = search(scoped, params[:keyword])
    scoped = order_by(scoped, params[:sort_scope], params[:order])
  end

  private def order_by(scoped, scope, sort = :desc) = scope ? scoped.public_send(scope, sort) : scoped

end
