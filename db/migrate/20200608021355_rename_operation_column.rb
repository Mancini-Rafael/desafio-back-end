class RenameOperationColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :operations, :type, :mode
  end
end
