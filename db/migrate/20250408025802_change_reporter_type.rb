class ChangeReporterType < ActiveRecord::Migration[8.0]
  def change
    change_column :reports, :reporter_id, :bigint
  end
end
