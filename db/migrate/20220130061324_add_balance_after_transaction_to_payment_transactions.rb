class AddBalanceAfterTransactionToPaymentTransactions < ActiveRecord::Migration[6.0]
  def change
    add_column :payment_transactions, :balance_after_transaction, :integer
  end
end
