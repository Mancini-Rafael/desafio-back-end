class CreateOperations < ActiveRecord::Migration[5.2]
  def change
    create_table :operations do |t|
      t.references :report
      t.string :type
      t.datetime :date
      t.string :receiver_cpf
      t.string :card
      t.string :store_owner_name
      t.string :store_name
      t.monetize :amount
      t.timestamps
    end
  end
end
