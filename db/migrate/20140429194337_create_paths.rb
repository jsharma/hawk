class CreatePaths < ActiveRecord::Migration
  def change
    create_table :hawk_xpaths do |t|
      t.string :targate_name
      t.string :xpath
			t.integer :hawker_id
      t.timestamps
    end
  end
end
