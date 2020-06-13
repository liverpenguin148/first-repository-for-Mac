class OmniauthCallbackController < Devise::OmniauthCallbacksController
  def twitter
    # request.env["omniauth.auth"]
    # OmniauthがTwitterから取得したデータを、ハッシュとして受け取っている
    @user = User.from_omniauth(request.env["omniauth.auth"].except("extra"))

    # request.env["omniauth.auth"]の情報を使用し、ユーザー登録がされているか検証
    if @user.persisted?
      # ユーザー登録済みの場合、ログインし、ユーザーページへ
      # persisted? オブジェクトが新しいレコードでない、かつ削除されてない場合、True
      sign_in_and_redirect @user
    else
      # ユーザーが永続化されていない場合、Omniauthのデータをセッションに格納
      session["devise.user_attributes"] = @user.attributes
      # 登録用ページに遷移
      redirect_to new_user_registration_url
    end
  end
end
