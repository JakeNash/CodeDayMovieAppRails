# This is the apiv2base controller. Yay
class BaseController < ApplicationController
  include Devise::Controllers::Helpers

  respond_to :json

  # helper_method :url_for_next_page
  # helper_method :url_for_previous_page
  helper_method :extend_params
  helper_method :json_error

  before_filter :log_user_agent
  before_filter :authenticate_user!

  after_filter :cors_set_access_control_headers
  skip_before_filter :authenticate_user!, :only => [:cors_preflight_check]

  # before_action :set_x_organization_header

  # has_scope :page, default: 1

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = '*' #'Origin, X-Requested-With, Content-Type, Accept, Authorization, Token'
      headers['Access-Control-Request-Method'] = '*'
      headers['Access-Control-Max-Age'] = '1728000'
      render :text => '', :content_type => 'text/plain'
    end
  end

  private

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Request-Method'] = '*'
    headers['Access-Control-Max-Age'] = "1728000"
  end


  def log_user_agent
    logger.info "USERAGENT: #{request.headers['HTTP_USER_AGENT']}"
  end

  def extend_params(params)
    request.query_parameters.merge(params)
  end

  # def url_for_next_page(collection, options = {})
  #   return nil if !collection.limit_value || collection.last_page?
  #   url_api_page(collection.current_page + 1)
  # end

  # def url_for_previous_page(collection, options = {})
  #   return nil if !collection.limit_value || collection.first_page?
  #   url_api_page(collection.current_page - 1)
  # end

  # def url_api_page(page)
  #   url = request.protocol + request.host_with_port + request.path
  #   url += "?#{extend_params(Kaminari.config.param_name => page).to_param}"
  # end
  
  # def set_x_organization_header
  #   response.headers["X-Organization-Last-Modified"] = current_organization.cached_at.try(:httpdate) if current_organization
  # end

  def json_error(obj)
    return json_error_hash(obj) if obj.is_a?(Hash)
    {errors: obj.errors.to_hash.merge({_full_messages: obj.errors.full_messages, _full_message: obj.errors.full_messages.join(', ')})}
  end

  def json_error_hash(hash)
    msg_array = hash.map { |key,value| "#{key.capitalize} #{value}"}
    {errors: hash.merge( _full_messages: msg_array, _full_message: msg_array.join(', '))}
  end

end
