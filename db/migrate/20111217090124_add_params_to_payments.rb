# -*- encoding : utf-8 -*-
class AddParamsToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :params, :text
  end
end
