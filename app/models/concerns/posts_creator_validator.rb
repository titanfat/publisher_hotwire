class PostsCreatorValidator < ActiveModel::Validator
  def validate(record)
    return unless !!record.title && !!record.publishable_type
    return unless record.authors.any?
    return unless !!record.date_publishing

    case record.publishable_type
    when 'Article'
      record.errors.add(:journal_id, 'должен быть указан для статьи') if record.journal_id.blank?
      record.errors.add(:doi, 'не должен быть указан для статьи') if record.doi.present?
    when 'Chapter'
      record.errors.add(:publisher, 'должен быть указан для главы') if record.publisher.blank?
      record.errors.add(:page_count, 'должен быть указан для главы') if record.page_count.blank?
    when 'Report'
      record.errors.add(:conference_name, 'должно быть указано для доклада') if record.conference_name.blank?
      record.errors.add(:conference_place, 'должно быть указано для доклада') if record.conference_place.blank?
    end
  end
end