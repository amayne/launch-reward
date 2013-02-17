class ChangeDefaultUserCounts < ActiveRecord::Migration
  def up
    change_column :users, :link_referral_count, :integer, :default => true
    change_column :users, :fb_referral_count, :integer, :default => true
    change_column :users, :twitter_referral_count, :integer, :default => true
    change_column :users, :email_referral_count, :integer, :default => true
  end

  def down
    change_column :users, :link_referral_count, :integer, :default => nil
    change_column :users, :fb_referral_count, :integer, :default => nil
    change_column :users, :twitter_referral_count, :integer, :default => nil
    change_column :users, :email_referral_count, :integer, :default => nil
  end
end
