class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.string :link
      t.text :content
      t.string :wg_id
      t.boolean :applied

      t.timestamps
    end
  end
end
