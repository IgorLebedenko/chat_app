module UsersHelper

  def avatar_for(user, options = { size: 70 })
    first_letter = user.name.lstrip[0].upcase
    image_path = "letters/#{first_letter}.png"
    image_tag(image_path, class: "avatar", size: "#{options[:size]}")
  end

  def signed_in_user
    unless signed_in?
      flash[:notice] = "Please sign in."
      redirect_to signin_url
    end
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_url) unless current_user?(@user)
  end

  def user_activity
    current_user.update_attribute(:last_activity_at, Time.now)
  end
end
