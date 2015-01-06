module SessionsHelper
	def sign_in(user)
		# 記憶トークン（暗号化していない生文字列）を新規作成
		remember_token = User.new_remember_token

		# 記憶トークン（生文字列）をクッキーに保存
		cookies.permanent[:remember_token] = remember_token
		# ※permanent は下の「20年後に期限切れになるクッキー」と同じ意味
		# cookies[:remember_token] = { value:   remember_token,
		# 														 expires: 20.years.from_now.utc }

		# 記憶トークンを暗号化して、DBに保存
		user.update_attribute(:remember_token, User.encrypt(remember_token))

		# 現在のユーザーに設定する ？？？
		self.current_user = user
	end

	def signed_in?
		!current_user.nil?
	end

	# ※C#的に言うと、current_user という名前のプロパティのsetメソッドを定義しているような感じ…
	#     instance.current_user = XXX
	#   というように呼び出せる
	def current_user=(user)
		@current_user = user
	end

	def current_user
		# クッキーの記憶トークンを暗号化する
		remember_token = User.encrypt(cookies[:remember_token])
		# 暗号化トークンをDbから検索し、@current_userにセットする
		@current_user ||= User.find_by(remember_token: remember_token)
	end

	def sign_out
		self.current_user = nil
		cookies.delete(:remember_token)
	end
end
