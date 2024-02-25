class CreateFlags < ActiveRecord::Migration[7.0]
  def change
    create_table :flags, id: false do |t|
      t.primary_key :code
      t.text :emoji

      t.timestamps
    end
  end
end
