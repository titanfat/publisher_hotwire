class PostsCreatorValidator < ActiveModel::Validator
  def validate(record)
    return unless  !!record.publishable_type
    return unless !!record.title
    return unless record.authors.any?
    return unless !!record.date_publishing
  end
end