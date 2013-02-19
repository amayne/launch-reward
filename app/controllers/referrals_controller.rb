class ReferralsController < ApplicationController

  def index
      session[:referral] = params[:id]
      session[:ref_source]  = request.referer
      redirect_to :controller=>'registrations', :action => 'new'
  end

end