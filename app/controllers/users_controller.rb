class UsersController < ApplicationController
  before_action :signed_in_user, only: [:index, :edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
    @current_user = current_user
    if @current_user == @user
      @chats = @user.chats.paginate(page: params[:page])
    else
      @chats = @user.chats.where(private: false).paginate(page: params[:page])
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Chat!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def index
    @users = User.paginate(page: params[:page], per_page: 15)
  end

  def messages
    @user = User.find(params[:id])
    @messages = @user.messages.paginate(page: params[:page], per_page: 10)
    if params[:content_search].present?
      @messages = @messages.search_by_content(params[:content_search])
    end

    if params[:date_search].present?
      begin
        date = Date.parse(params[:date_search])
        @messages = @messages.where(created_at: date..date.end_of_day)
      rescue
      end
    end
    render 'show_messages'
  end


  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
