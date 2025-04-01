class ApplicationQuery
  include Pagy::Backend

  private attr_reader :relation
  def initialize(relation) = @relation = relation

  def resolve(params) = raise NotImplementedError

  private def search(relation, column = title, query = nil)
    query ? relation.where("'%?%' ILIKE ? '%?%'", column, query) : relation
  end

  private def per_page(scoped, page = 0)
    scoped.offset(params[:offset]).limit(params[:limit])
  end
end
