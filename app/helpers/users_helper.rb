module UsersHelper
  # 与えられたユーザーのGravatar (http://gravatar.com/) を返す。
  # ※演習7.6.1 gravatorのサイズ指定オプションを追加
  def gravatar_for(user, options = { size: 100 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "http://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.name, class: "gravatar")
  end
end
