class User < ActiveRecord::Base
  rolify
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me, :opt_in, :confirmed

  after_create :send_welcome_email

  # override Devise method
  # no password is required when the account is created; validate password when the user sets one
  validates_confirmation_of :password
  def password_required?
    if !persisted?
      !(password != "")
    else
      !password.nil? || !password_confirmation.nil?
    end
  end

  # override Devise method
  def confirmation_required?
    false
  end

  # override Devise method
  def active_for_authentication?
    confirmed? || confirmation_period_valid?
  end

  private

  def send_welcome_email
    unless self.email.include?('@example.com')  && Rails.env != 'test' # excluding @example.com, to avoid resending emails when db is reset
      UserMailer.welcome_email(self).deliver
    end
  end

  # new function to set the password
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

# new function to determine whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

# new function to provide access to protected method pending_any_confirmation
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end
end