class AddParamsToPayments < ActiveRecord::Migration
  def change
    add_column :spree_payments, :params, :text
  end
end
