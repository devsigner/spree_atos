class BillingIntegration::Atos < BillingIntegration
  preference :merchant_id,      :string,  :default => '014213245611111'
  preference :merchant_country, :string,  :default => 'fr'
  preference :currency_code,    :integer, :default => 978
  
  def payment_profiles_supported?
    true
  end
end
