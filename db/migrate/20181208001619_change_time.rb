class ChangeTime < ActiveRecord::Migration[5.2]
  def change
    remove_column :interventions, :interventionStartTime
    remove_column :interventions, :interventionEndTime
    add_column :interventions, :interventionStartTime, :string
    add_column :interventions, :interventionEndTime, :string
  end
end
