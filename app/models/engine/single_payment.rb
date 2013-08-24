class Engine::SinglePayment
  def create_payments(commission)
    Payment.create(
      amount: commission.amount,
      payment_date: commission.payment_date,
      user: commission.user,
      commission: commission
    )
  end
end
