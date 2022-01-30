class PaymentTransactionsController < ApplicationController
  def new
    if current_user
      @payment_transaction = PaymentTransaction.new
    else
      redirect_to new_user_session_path
    end
  end

  def index
    
    @transactions = PaymentTransaction.where(user_id: current_user.id).or(PaymentTransaction.where(to_whom: current_user.id)).all
  end

  def create
    user = current_user
    if user.wallet.balance > payment_transaction_params[:ammount].to_f
      @payment_transaction = user.payment_transactions.create(payment_transaction_params)
      @payment_transaction.wallet_id = user.wallet.id
      @payment_transaction.save
      redirect_to user_wallet_path(user.id, user.wallet.id)
    else
      redirect_to new_payment_transaction_path
    end
  end

  private

  def payment_transaction_params
    params.require(:payment_transaction).permit(:ammount, :to_whom,)
  end
end
