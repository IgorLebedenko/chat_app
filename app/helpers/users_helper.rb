module UsersHelper

  def avatar_for(user, options = { size: 70 })
    first_letter = user.name.lstrip[0].upcase
    image_path = "letters/#{first_letter}.png"
    image_tag(image_path, class: "avatar", size: "#{options[:size]}")
  end
end
