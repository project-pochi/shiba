class SittersController < ApplicationController

  def index
    query = {}

    if params[:zip_code] && zip_code = params[:zip_code].match(/\A\d{3}\-\d{4}\z/)
      query[:zip_code] = zip_code[0]
      @locations = Location.near(zip_code[0], 1, :select => 'zip_code')
      logger.debug @locations.inspect
      @users = User.where(:encrypted_zip_code => @locations.map(&:zip_code))
      logger.debug @users.inspect
    end

    render :text => query
  end

  def new
    if logged_in?
      @user = current_user
      @sitter = Sitter.new
    else
      redirect_to login_path
    end
  end

  def create
    @sitter = Sitter.new(sitter_params)

    if logged_in?
      @user = current_user
      @sitter.user_id = @user.id

      if @sitter.save
        flash[:info] = "You became a sitter!!"
        redirect_to @user
      else
        render :new
      end

    else
      redirect_to login_path
    end
  end

  private
    def sitter_params
      params.require(:sitter).permit(
        :residence_type_id,
        :capacity_type_id,
        :has_dog_from
      )
    end
end
