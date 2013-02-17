class AddSocialReferralColumnsToUser < ActiveRecord::Migration
  def change
    # referral token
    add_column :users, :referral_token, :string

    # referral counters
    add_column :users, :link_referral_count, :integer
    add_column :users, :fb_referral_count, :integer
    add_column :users, :twitter_referral_count, :integer
    add_column :users, :email_referral_count, :integer

    # actions taken
    add_column :users, :fb_like_page, :boolean
    add_column :users, :fb_post_to_wall, :boolean
    add_column :users, :twitter_follow, :boolean
    add_column :users, :twitter_tweet, :boolean
    add_column :users, :email_referral_sent, :boolean

    # indexes
    add_index :users, :referral_token, :unique => true
  end
end
