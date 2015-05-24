#This controller allows you to get a users api token with a given email/password combo
class TokenController < BaseController

  skip_before_filter :authenticate_user!
  # skip_before_filter :set_raven_context
  respond_to :json
  action :only => [:create]

  def create
    @user = User.new

    if !params_present?
      if !params[:user][:email]
        @user.errors.add(:email, 'not present')
      end
      @user.errors.add(:password, 'not present') if !params[:user][:password]
    end

    if !@user.errors.any?
      user_to_authenticate = User.find_for_database_authentication(:email => params[:user][:email])
      @user.errors.add(:email, 'address not found') if user_to_authenticate.nil?
    end


    if !@user.errors.any?
      @user = user_to_authenticate

      @user.errors.add(:password, 'could not be authenticated successfully') if !user_to_authenticate.valid_password?(params[:user][:password])
    end

    if @user.errors.any?
      render users_path,
             :status => 422
    else
      render users_path
    end
  end
  
  private

  def params_present?
    user = params[:user]
    user and user[:email] and user[:password]
  end

end
