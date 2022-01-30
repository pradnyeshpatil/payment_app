class PaymentTransactionsController < ApplicationController
  def new
    if current_user
      if current_user.verified
        @payment_transaction = PaymentTransaction.new
      else
        redirect_to root_path, alert: 'Your KYC varification is pending'
      end
    else
      redirect_to new_user_session_path
    end
  end

  def index
    if current_user
      @transactions = PaymentTransaction.where(user_id: current_user.id).or(PaymentTransaction.where(to_whom: current_user.id)).all
    else
      redirect_to new_user_session_path
    end
  end

  def generate_report
    book = Spreadsheet::Workbook.new
    transaction_sheet = book.create_worksheet(name: 'First sheet')
    @transactions = PaymentTransaction.where(user_id: current_user.id).or(PaymentTransaction.where(to_whom: current_user.id, created_at: DateTime.now.beginning_of_day..DateTime.now - 1.minute)).all
    transaction_sheet.row(0).push('Transaction Id', 'Message', 'From', 'To', 'Amount', 'Status', 'Date')
    i = 1
    @transactions.each do |transaction|
      transaction_sheet.row(i).push(transaction.id, transaction.message, transaction.user_id, transaction.to_whom, transaction.ammount, transaction.user_id == current_user.id ? "Debited" : "Credited" , (transaction.created_at).strftime('%d/%m/%Y %H:%M %p'))
      i = i + 1
    end
    book.write 'test.xls'
    send_file("test.xls", :disposition => 'attachment', :filename => "transaction_history.xls", type: "application/xml")
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
    params.require(:payment_transaction).permit(:ammount, :to_whom, :message)
  end
end
