class ApplicationQuery
  ALLOW_COLUMN = [].freeze
  include Pagy::Backend

  private attr_reader :relation
  def initialize(relation) = @relation = relation

  def resolve(params) = raise NotImplementedError

  private def search(relation, query = nil)
    return relation if query.blank?

    define_class = relation.model
    define_class.where(id: "#{define_class}Search".safe_constantize.search(query).select(:post_id))

  # raise NotImplementedError

    # earlier rewritten like query
    # q = "%#{ActiveRecord::Base.sanitize_sql_like(query)}%"
    #
    # conditions = self.class::ALLOW_COLUMN.map {
    #   relation.model.arel_table[_1.to_sym].matches(q)
    # }.reduce(&:or)
    # relation.where(conditions)
  end
end
