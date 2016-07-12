class SittersController < ApplicationController

  DAYS_MAP = [
    "sunday    = 1",
    "monday    = 1",
    "tuesday   = 1",
    "wednesday = 1",
    "thursday  = 1",
    "friday    = 1",
    "saturday  = 1",
  ]

  def index
    query = {}

    if params[:zip_code].present? && zip_code = params[:zip_code].match(/\A\d{3}\-\d{4}\z/)
      @locations = Location.near(zip_code[0], 1, :select => 'zip_code')
      logger.debug @locations.inspect

      query[:zip_code] = @locations.map(&:zip_code).uniq
    end

    if params[:start].present? && params[:end].present?
      start_date = Date.parse(params[:start])
      end_date   = Date.parse(params[:end])

      @sitter_busy_dates = SitterBusyDate.where(start: (start_date..end_date))
      logger.debug @sitter_busy_dates.inspect

      logger.debug start_date.wday
      logger.debug end_date.wday
      target_days = DAYS_MAP[start_date.wday..end_date.wday]
      if start_date.wday >= end_date.wday
        target_days = (DAYS_MAP[0..end_date.wday] + DAYS_MAP[start_date.wday..6]).uniq
      end
      logger.debug target_days.inspect
      @sitter_busy_days = SitterBusyDay.where(target_days.join(" OR "))
      logger.debug @sitter_busy_days.inspect

      query[:busy_sitter_id] = (@sitter_busy_dates.map(&:sitter_id) + @sitter_busy_days.map(&:sitter_id)).uniq
      logger.debug query[:busy_sitter_id].inspect
    end

    @sitters = nil
    if query[:zip_codes].present? && query[:busy_sitter_id].present?
      @sitters = Sitter.where(zip_code: query[:zip_code]).where.not(id: query[:busy_sitter_id])
    elsif query[:zip_codes].present?
      @sitters = Sitter.where(zip_code: query[:zip_code])
    elsif query[:busy_sitter_id].present?
      @sitters = Sitter.where.not(id: query[:busy_sitter_id])
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
