require 'spec_helper'

describe Engine::SinglePayment do
  describe '#create_payments' do
    it 'will create Payments based on a Commission' do
      payment_date = Time.now
      user = create(:user)
      commission = create(
        :commission,
        amount: 100,
        payment_date: payment_date,
        user: user
      )
      payment_engine = Engine::SinglePayment.new

      payment = payment_engine.create_payments(commission)

      expect(payment.amount).to eq 100.00
      expect(payment.payment_date).to eq payment_date
      expect(payment.user).to eq user
      expect(payment.commission).to eq commission
    end
  end
end
