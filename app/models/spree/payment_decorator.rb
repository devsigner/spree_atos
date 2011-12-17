Spree::Payment.class_eval do
  serialize :params, Hash
end
