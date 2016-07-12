class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @sitter = Sitter.find_by(user_id: @user.id)

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

  private

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
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
end
