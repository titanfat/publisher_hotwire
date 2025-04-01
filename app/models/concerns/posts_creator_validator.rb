class PostsCreatorValidator < ActiveModel::Validator
  def validate(record)
    return unless !!record.title && !!record.publishable_type
    return unless record.authors.any?
    return unless !!record.date_publishing


    if record.publishable_type == 'Article'
      unless !!record.doi && !!record.journal_id
        record.errors.add(:base, 'не валидная статья')
      end
      end

    if record.publishable_type == 'Chapter'
      unless !!record.publisher && !!record.page_count
        record.errors.add(:base, 'не валидная статья')
      end
    end

    if record.publishable_type == 'Report'
      unless !!record.conference_name && !!record.conference_place
        record.errors.add(:base, 'не валидная статья')
      end
    end
  end
end