class CreateShortlinks < ActiveRecord::Migration[5.1]
  def change
    create_table :shortlinks do |t|
      t.string :slug
      t.text :destination

      t.timestamps
    end
  end
end
