module UsersHelper
  def image_for(user)
    image_tag(user.github_avatar, alt: user.short_name, class: "img-thumbnail", size: "120")
  end
end
