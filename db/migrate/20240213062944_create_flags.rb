class CreateFlags < ActiveRecord::Migration[7.0]
  def change
    create_table :flags, id: false do |t|
      t.string :code, null: false, primary_key: true, limit: 2
      t.text :emoji

      t.timestamps
    end
  end
end
