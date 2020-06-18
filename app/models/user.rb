class User < ApplicationRecord
# テーブル定義
# +------------------------+--------------+------+-----+---------+----------------+
# | Field                  | Type         | Null | Key | Default | Extra          |
# +------------------------+--------------+------+-----+---------+----------------+
# | id                     | bigint(20)   | NO   | PRI | NULL    | auto_increment |
# | email                  | varchar(255) | NO   | UNI |         |                |
# | encrypted_password     | varchar(255) | NO   |     |         |                |
# | reset_password_token   | varchar(255) | YES  | UNI | NULL    |                |
# | reset_password_sent_at | datetime     | YES  |     | NULL    |                |
# | remember_created_at    | datetime     | YES  |     | NULL    |                |
# | sign_in_count          | int(11)      | NO   |     | 0       |                |
# | current_sign_in_at     | datetime     | YES  |     | NULL    |                |
# | last_sign_in_at        | datetime     | YES  |     | NULL    |                |
# | current_sign_in_ip     | varchar(255) | YES  |     | NULL    |                |
# | last_sign_in_ip        | varchar(255) | YES  |     | NULL    |                |
# | confirmation_token     | varchar(255) | YES  | UNI | NULL    |                |
# | confirmed_at           | datetime     | YES  |     | NULL    |                |
# | confirmation_sent_at   | datetime     | YES  |     | NULL    |                |
# | unconfirmed_email      | varchar(255) | YES  |     | NULL    |                |
# | failed_attempts        | int(11)      | NO   |     | 0       |                |
# | unlock_token           | varchar(255) | YES  | UNI | NULL    |                |
# | locked_at              | datetime     | YES  |     | NULL    |                |
# | created_at             | datetime     | NO   |     | NULL    |                |
# | updated_at             | datetime     | NO   |     | NULL    |                |
# | provider               | varchar(255) | YES  |     | NULL    |                |
# | uid                    | varchar(255) | YES  |     | NULL    |                |
# | username               | varchar(255) | YES  |     | NULL    |                |
# +------------------------+--------------+------+-----+---------+----------------+

	validates :username, presence: true
	validates :username, length: { minimum: 4 }
	validates :username, length: { maximum: 30 }

	has_many :tasks

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
