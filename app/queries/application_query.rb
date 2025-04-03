class ApplicationQuery
  ALLOW_COLUMN = [].freeze
  include Pagy::Backend

  private attr_reader :relation
  def initialize(relation) = @relation = relation

  def resolve(params) = raise NotImplementedError

  private def search(relation, column = title, query = nil)
    return relation unless self.class::ALLOW_COLUMN.include?(column.to_s)
    query ? relation.where(@relation.model.arel_table[column.to_sym].matches("%#{ActiveRecord::Base.sanitize_sql_like(query)}%")) : relation
  end
end
