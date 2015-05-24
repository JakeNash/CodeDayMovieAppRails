if @user.errors.any?
  json.exception 'AuthError'
  json.message 'Unauthorized: Incorrect email or password'
  json.errors json_error(@user)[:errors]
else
  json.authentication_token @user.authentication_token
  json.user do |json|
    json.(@user, :id, :email)
  end
end
