class RegistrationsController < Devise::RegistrationsController



  def new
    logger.debug(session[:ref_user])
    resource = build_resource({})
    respond_with resource
  end

  # override #create to respond to AJAX with a partial
  def create
    build_resource

    if resource.save
      trigger_referral_count(params[:user][:email], session[:referral], session[:ref_source])

      if resource.active_for_authentication?
        sign_in(resource_name, resource)
        (render(:partial => 'thankyou', :layout => false) && return)  if request.xhr?
        respond_with resource, :location => after_sign_up_path_for(resource)
      else
        expire_session_data_after_sign_in!
        (render(:partial => 'thankyou', :layout => false) && return)  if request.xhr?
        respond_with resource, :location => after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      render :action => :new, :layout => !request.xhr?
    end
  end

  protected

  def after_inactive_sign_up_path_for(resource)
    '/thankyou.html'
  end

  def after_sign_up_path_for(resource)
    # the page new users will see after sign up (after launch, when no invitation is needed)
    redirect_to root_path
  end

  private

  def trigger_referral_count(curr_user_email, referral, referral_source)
    referrer = User.find_by_referral_token(referral[1..-1])
    if referral[0] == 'f' # facebook
      referrer.fb_referral_count += 1
    elsif referral[0] == 't' # twitter
      referrer.twitter_referral_count += 1
    elsif referral[0] == 'l' # link
      referrer.link_referral_count += 1
    elsif referral[0] == 'e' # email
      referrer.email_referral_count += 1
    end
    referrer.save
    user = User.find_by_email(curr_user_email)
    user.referred_by_id = referrer.id
    #user.referred_by=referrer
    #user.referral_url = referral
    logger.debug(user.referred_by)
    user.save
  end
end