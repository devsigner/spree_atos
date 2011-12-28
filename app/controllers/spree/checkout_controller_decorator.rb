Spree::CheckoutController.class_eval do
  before_filter :redirect_to_atos_form_if_needed, :only => :update
  skip_before_filter :verify_authenticity_token, :only => [:cancel_atos, :complete_atos]
  
  def atos
    payment_method = Spree::PaymentMethod.find(params[:payment_method_id])
    prefs = payment_method.preferences
    
    payment_request = Payme::Request.new((@order.total * 100).to_i,
      :bin_path               => 'bin/sogenactif',
      :pathfile               => 'config/sogenactif/pathfile',
      :order_id               => @order.number,
      :merchant_id            => prefs[:merchant_id],
      :currency_code          => prefs[:currency_code],
      :merchant_country       => prefs[:merchant_country],
      :normal_return_url      => complete_atos_checkout_url,
      :cancel_return_url      => cancel_atos_checkout_url,
      :automatic_response_url => atos_payment_notifications_url(:payment_method_id => payment_method),
      :customer_ip_address    => request.remote_ip,
      :customer_email         => @order.email
    )
    
    _, error, msg, @atos_form = payment_request.launch
    
    if error != "0"
      flash[:error] = t(:spree_gateway_error_flash_for_checkout)
      render :edit
    end
  end
  
  # Atos redirects the user back via a POST request. Here we're redirecting her
  # to the "payment" checkout step when she presses the cancel button.
  def cancel_atos
    redirect_to checkout_state_url(:payment)
  end
  
  def complete_atos
    if @order.completed?
      session[:order_id] = nil
      flash[:notice] = t(:order_processed_successfully)
      redirect_to order_url(@order)
    else
      flash[:error] = t(:payment_processing_failed)
      redirect_to checkout_state_url(:payment)
    end
  end
  
  protected
    def redirect_to_atos_form_if_needed
      return unless params[:state] == "confirm" && params[:order][:payments_attributes]
      payment_method = Spree::PaymentMethod.find(params[:order][:payments_attributes].first[:payment_method_id])

      if Spree::BillingIntegration::Atos === payment_method
        @order.update_attributes(object_params)
        redirect_to atos_checkout_url(:payment_method_id => payment_method)
      end
    end
end
