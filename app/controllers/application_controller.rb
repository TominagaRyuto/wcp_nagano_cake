class ApplicationController < ActionController::Base
  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_top_path
    when Customer
      if request.referer&.include?("/sign_in")
        root_path
      else
        customers_path
      end
    end
  end

  def after_sign_out_path_for(resource)
    if resource == :admin
      new_admin_session_path
    else
      root_path
    end
  end

  def after_sign_up_path_for(resource)
    binding.pry
    customers_path
  end

  def after_inactive_sign_up_path_for(resource)
    binding.pry
    customers_path
  end

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate,except: [:top, :about]

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :is_active])
  end

  def authenticate
    if admin_signed_in?
      authenticate_admin!
    else
      authenticate_customer!
    end
  end

end
