class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @sitter = Sitter.find_by(user_id: @user.id)

    @sitter_busy_dates = SitterBusyDate.new
    @sitter_busy_days = SitterBusyDay.new
    unless @sitter.nil?
      @sitter_busy_dates = SitterBusyDate.where(sitter_id: @sitter.id)
      logger.debug @sitter_busy_dates.inspect
      @sitter_busy_days = SitterBusyDay.find_by(sitter_id: @sitter.id)

      #@user_events = [ { "id": 1, "title": "test", "allDay": false, "start": "2016-07-12T19:09:16", "end": "2016-07-15T19:09:16" } ]
    end
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)

    if @user.save
      # Handle a successful save.
      # log_in @user
      # flash[:success] = "Welcome to the Sample App!"
      # redirect_to @user
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  def update
    if email_update_param.present?
      # TODO
      # deactivate account
      # send email
      # clear session
      redirect_to root_url

    elsif password_update_param.present?
      # TODO
      # deactivate account
      # send email
      # clear session
      redirect_to root_url

    elsif nickname_update_param[:nickname].present?
      new_nickname = nickname_update_param[:nickname]

      if new_nickname.length > 16
        flash[:error] = "Invalid nickname"
        render :edit
        return
      end

      if @user.update_attribute(:nickname, new_nickname)
        flash[:success] = "User was successfully updated."
        redirect_to @user
        return
      end

    elsif phone_update_param[:encrypted_phone_number].present?
      new_phone_number = phone_update_param[:encrypted_phone_number]
      # TODO: validation

      if @user.update_attribute(:encrypted_phone_number, new_phone_number)
        flash[:success] = "User was successfully updated."
        redirect_to @user
        return
      end

    end

      render :edit
  end

  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:first_name,
                                   :last_name,
                                   :nickname,
                                   :encrypted_email_address,
                                   :encrypted_phone_number,
                                   :gender,
                                   :birthdate,
                                   :password,
                                   :password_confirmation)
    end

    def nickname_update_param
      params.require(:user).permit(:nickname)
    end

    def email_update_param
      params.require(:user).permit(:encrypted_email_address)
    end

    def phone_update_param
      params.require(:user).permit(:encrypted_phone_number)
    end

    def password_update_param
      params.require(:user).permit(:password, :password_confirmation)
    end
end
