class CreateHawkHawkers < ActiveRecord::Migration
  def change
    create_table :hawk_hawkers do |t|
      t.string :url
      t.timestamps
    end
  end
end
