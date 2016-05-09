class SittersController < ApplicationController

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
      params.require(:sitter).permit(:residence_type_id,
                                   :capacity_type_id,
                                   :has_dog_from)
    end
end
