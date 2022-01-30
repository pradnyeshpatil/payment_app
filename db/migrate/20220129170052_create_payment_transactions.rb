class CreatePaymentTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :payment_transactions do |t|
      t.integer :to_whom, null: false
      t.integer :ammount, null: false
      t.string :message
      t.references :wallet, null: false, foreign_key: true

      t.timestamps
    end
  end
end
