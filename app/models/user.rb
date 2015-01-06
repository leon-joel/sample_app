class User < ActiveRecord::Base
  before_save { email.downcase! }					# ブロックをコールバックに登録
  before_create :create_remember_token		# メソッド参照でコールバックを登録
  
  validates :name, presence: true, length: {maximum: 50}

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX},
                    uniqueness: { case_sensitive: false }

  has_secure_password

  validates :password, length: { minimum: 6 }

  # 記憶トークン（暗号化前）を生成する ※クラスメソッド
  def User.new_remember_token
  	SecureRandom.urlsafe_base64
  end

  # 暗号化 ※クラスメソッド
  def User.encrypt(token)
  	Digest::SHA1.hexdigest(token.to_s)
  end

  # 記憶トークンを生成してインスタンス変数 remember_token にセットする ※インスタンスメソッド
  private
  	def create_remember_token
  		self.remember_token = User.encrypt(User.new_remember_token)
  	end
end
