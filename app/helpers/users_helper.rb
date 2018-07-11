module UsersHelper

  def gravatar_for(user, size: 80)
    g_id = Digest::MD5::hexdigest(user.email.downcase)
    g_url = "//www.gravatar.com/avatar/#{g_id}?size=#{size}"
    image_tag g_url, alt: user.name, class: 'gravatar'
  end
end
