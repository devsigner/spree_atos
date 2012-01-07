module SpreeAtos
  class Engine < Rails::Engine
    engine_name 'spree_atos'
    
    config.autoload_paths += ["#{config.root}/lib"]
    
    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
    end
    
    config.after_initialize do |app|
      app.config.spree.payment_methods += [
        BillingIntegration::Atos
      ]
    end
    
    config.to_prepare &method(:activate)
  end
end
