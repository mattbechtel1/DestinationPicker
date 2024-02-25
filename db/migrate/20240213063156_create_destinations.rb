class CreateDestinations < ActiveRecord::Migration[7.0]
  def change
    create_table :destinations do |t|
      t.string :name
      t.string :city
      t.references :language_primary, null: false, foreign_key: {to_table: :languages}
      t.references :language_secondary, null: true, foreign_key: {to_table: :languages}
      t.references :flag_primary, null: false, foreign_key: {to_table: :flags, primary_key: :code}, type: :string
      t.references :flag_secondary, null: true, foreign_key: {to_table: :flags, primary_key: :code}, type: :string
      t.text :breakdown
      t.references :region, null: false, foreign_key: true
      t.integer :population

      t.timestamps
    end
  end
end
