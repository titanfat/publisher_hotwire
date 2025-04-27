class AddSearchableFullNameUsers < ActiveRecord::Migration[8.0]
  disable_ddl_transaction!

  def up
    safety_assured do
      execute <<-SQL
        ALTER TABLE users
        ADD COLUMN searchable_full_name tsvector GENERATED ALWAYS as (
            SETWEIGHT(TO_TSVECTOR('simple', COALESCE(first_name, '')), 'A') ||
            SETWEIGHT(TO_TSVECTOR('simple', COALESCE(last_name, '')), 'B')
        ) stored;
      SQL
    end
  end

  def down
    safety_assured do
      execute <<-SQL
        alter table users
        drop column searchable_full_name
      SQL
    end
  end
end
