class ReferralsController < ApplicationController

  def index
    user = User.find_by_referral_token(params[:id][1..-1])

    if user.nil?
      # do nothing
    else
      # check for strict referrals?
      # request.referer
      # check the first character for referral source
      #puts user
      if params[:id][0] == 'f' # facebook
         user.fb_referral_count += 1
      elsif params[:id][0] == 't' # twitter
        user.twitter_referral_count += 1
      elsif params[:id][0] == 'l' # link
        user.link_referral_count += 1
      elsif params[:id][0] == 'e' # email
        user.email_referral_count += 1
      end
      user.save
    end

  end

end