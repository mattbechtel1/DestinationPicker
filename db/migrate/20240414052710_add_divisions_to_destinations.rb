class AddDivisionsToDestinations < ActiveRecord::Migration[7.0]
  def change
    add_column :destinations, :divisions, :string
  end
end
