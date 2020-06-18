class User < ApplicationRecord
	validates :username, presence: true
	validates :username, length: { minimum: 4 }
	validates :username, length: { maximum: 12 }

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :omniauthable, omniauth_providers: [:twitter]

	# providerとuidでDBを検索し、あったらその情報を、無かったらレコードを新規作成
	def self.from_omniauth(auth)
		# provider = auth["provider"]、uid = auth["uid"] のデータがあれば、findされる。
		find_or_create_by(provider: auth["provider"], uid: auth["uid"]) do |user|
			# provider = auth["provider"]、uid = auth["uid"] のデータが無ければ、
			# user.provider,uid,usernameに auth["provider"],auth["uid"],auth["info"]["nickname"]のデータを作成
			user.provider = auth["providers"]
			user.uid = auth["uid"]
			user.username = auth["info"]["nickname"]
		end
	end

	# リソースをビルドする前に自動的に呼ばれる
	def self.new_with_session(params, session)
		if session["devise.user_attributes"]
			new(session["devise.user_attributes"]) do |user|
				user.user_attributes = params
				user.valid?
			end
		else
			super
		end
	end
end
