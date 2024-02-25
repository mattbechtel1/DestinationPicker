class RemoveEmojiFromFlags < ActiveRecord::Migration[7.0]
  def change
    remove_column :flags, :emoji
  end
end
