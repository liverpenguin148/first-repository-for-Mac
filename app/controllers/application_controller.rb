class ApplicationController < ActionController::Base
  # CSRF対策
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  # ログイン後、user#showページへ遷移
  def after_sign_in_path_for(resource)
    pages_show_path
  end

  private
  # ユーザーがログインしていない場合、ログインページへ遷移
    def sign_in_required
      redirect_to new_user_session_url unless user_signed_in?
    end

  protected
  # deviseでは、デフォルトで Strong Paramterが設定されているため、
  # 新しいパラメータを登録したい場合、下記メソッドで設定する必要がある。
    def configure_permitted_parameters
      # :sign_up → Devise::RegistrationsController#create アクションで、usernameを追加
      devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
      # :account_update → Devise::RegistrationsController#update アクションで、usernameを追加
      devise_parameter_sanitizer.permit(:account_update, keys: [:username])
    end
end
