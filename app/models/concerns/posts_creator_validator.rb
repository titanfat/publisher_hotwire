class PostsCreatorValidator < ActiveModel::Validator
  def validate(record)
    return unless !!record.title
    return unless record.authors.any?
    return unless !!record.date_publishing
    return unless !!record.publishable
  end
end