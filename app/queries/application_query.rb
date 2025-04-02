class ApplicationQuery
  ALLOW_COLUMN = [].freeze
  include Pagy::Backend

  private attr_reader :relation
  def initialize(relation) = @relation = relation

  def resolve(params) = raise NotImplementedError

  private def search(relation, column = title, query = nil)
    return relation unless self.class::ALLOW_COLUMN.include?(column.to_s)

    query ? relation.where("#{column} ILIKE ?", "%#{query}%") : relation
  end

  private def per_page(scoped, page = 0)
    scoped.offset(params[:offset]).limit(params[:limit])
  end
end
