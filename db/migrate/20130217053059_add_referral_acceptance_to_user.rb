class AddReferralAcceptanceToUser < ActiveRecord::Migration
  def change
    add_column :users, :referred_by_id, :integer
  end
end
