# -*- encoding : utf-8 -*-
class Atos::PaymentNotificationsController < Spree::BaseController
  skip_before_filter :verify_authenticity_token
  
  def create
    payment_params = Payme::Response.new(params[:DATA]).launch
    payment_method = PaymentMethod.find(params[:payment_method_id])
    code = payment_params[:response_code]
    
    @order = Order.find_by_number!(payment_params[:order_id])
    
    @payment = @order.payments.create(
      :payment_method => payment_method,
      :amount => payment_params[:amount].to_i / 100.0,
      :response_code => code,
      :params => payment_params)
    
    @payment.started_processing!
    
    if code == '00'
      @payment.complete!
      # need to force checkout to complete state
      # (extracted from https://github.com/spree/spree_paypal_express)
      until @order.state == "complete"
        @order.update! if @order.next!
      end
    else
      @payment.failure!
    end
    
    render :nothing => true
  end
end
