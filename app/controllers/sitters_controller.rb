class SittersController < ApplicationController

  def index
    query = {}

    if params[:zip_code].present? && zip_code = params[:zip_code].match(/\A\d{3}\-\d{4}\z/)
      @locations = Location.near(zip_code[0], 1, :select => 'zip_code')
      logger.debug @locations.inspect

      query[:zip_code] = @locations.map(&:zip_code)
    end

    if params[:start].present? && params[:end].present?
      request_dates = (Date.parse(params[:start])..Date.parse(params[:end]))
      logger.debug request_dates.inspect
      @sitter_busy_dates = SitterBusyDate.where(:start => request_dates)
      logger.debug @sitter_busy_dates.inspect

      query[:busy_sitter_id] = @sitter_busy_dates.map(&:sitter_id)
    end

    @sitters = nil
    if query[:zip_codes] && query[:busy_sitter_id]
      @sitters = Sitter.where(:zip_code => query[:zip_code]).where.not(:id => query[:busy_sitter_id])
    elsif query[:zip_codes]
      @sitters = Sitter.where(:zip_code => query[:zip_code])
    elsif query[:busy_sitter_id]
      @sitters = Sitter.where.not(:id => query[:busy_sitter_id])
    else
      @sitters = Sitter.all
    end

    #@sitters = Sitter.where(:zip_code => @locations.map(&:zip_code))
    logger.debug @sitters.inspect

    @users = User.where(:id => @sitters.map(&:user_id))
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
        @location = Location.new({ :zip_code => @sitter.zip_code })
        @location.save

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
        :zip_code,
        :residence_type_id,
        :capacity_type_id,
        :has_dog_from
      )
    end
end
