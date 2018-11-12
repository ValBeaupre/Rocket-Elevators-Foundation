class CreateAuthors < ActiveRecord::Migration[5.2]
  def change
    create_table :authors do |t|
      t.references :employee, foreign_key: true

      t.timestamps
    end
  end
end
