ApplicationController.class_eval do
  prepend_before_filter :clear_cart_if_order_completed, :except => :complete_atos
  
  protected
    def clear_cart_if_order_completed
      if session[:order_id]
        session[:order_id] = nil if current_order.completed?
      end
    end
end
