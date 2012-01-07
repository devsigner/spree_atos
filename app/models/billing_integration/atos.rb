class BillingIntegration::Atos < BillingIntegration
  preference :merchant_id,      :string,  :default => ''
  preference :merchant_country, :string,  :default => 'fr' # France
  preference :currency_code,    :integer, :default => 978  # Euros
  
  def payment_profiles_supported?
    true
  end
end
