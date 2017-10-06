class CalendarsController < ApplicationController
  require 'date'
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]
  before_action :today_check, only: [:new]
  before_action :set_calendar_ym, only: [:index]
  before_action :authenticate_user!

  # GET /calendars
  # GET /calendars.json
  def index
    @now = Time.current
    @set_calendar_ym = (set_calendar_ym)

    if @set_calendar_ym[:month] == "0"
      @show_month = (@set_calendar_ym[:month] = "12").to_i.abs
      @show_year = (@set_calendar_ym[:year].to_i - 1).abs
    elsif (1..12).include?(@set_calendar_ym[:month].to_i)
      @show_month = @set_calendar_ym[:month].to_i.abs
      @show_year = @set_calendar_ym[:year].to_i.abs
    elsif @set_calendar_ym[:month] == "13"
      @show_month = (@set_calendar_ym[:month] = "1").to_i.abs
      @show_year = (@set_calendar_ym[:year].to_i + 1).abs
    else
      @show_month = @now.end_of_month.strftime("%m").to_i.abs
      @show_year = @now.end_of_month.strftime("%Y").to_i.abs
    end

    @ymd = "01/#{@show_month.to_i}/#{@show_year}"
    if @set_calendar_ym.present?
    @month = @ymd.to_time.end_of_month.strftime("%d").to_i.abs
    else
    @month = @now.end_of_month.strftime("%d").to_i.abs
    end
    @calendars = Calendar.where(created_at: @now.beginning_of_month..@now.end_of_month, user_id: current_user.id)
    @calendar = current_user.calendar.new(calendar_params_new)


  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show
  end

  # GET /calendars/new
  def new
    @calendar = current_user.calendar.new(calendar_params_new)
  end

  # GET /calendars/1/edit
  def edit
  end

  # POST /calendars
  # POST /calendars.json
  def create

    if current_user.calendar.find_by(created_at: @now).present? == false
      @calendar = current_user.calendar.last
      @calendar.update(calendar_params)
    else
      @calendar = current_user.calendar.new(calendar_params)
      respond_to do |format|
        if @calendar.save
          format.html { redirect_to calendars_path, notice: '今日のデータを更新しました。' }
          format.json { render :show, status: :created, location: @calendar }
        else
          format.html { render :new }
          format.json { render json: @calendar.errors, status: :unprocessable_entity }
        end
      end
    end

  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to @calendar, notice: 'Calendar was successfully updated.' }
        format.json { render :show, status: :ok, location: @calendar }
      else
        format.html { render :edit }
        format.json { render json: @calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calendars/1
  # DELETE /calendars/1.json
  def destroy
    @calendar.destroy
    respond_to do |format|
      format.html { redirect_to calendars_url, notice: 'Calendar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calendar
      @calendar = Calendar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def calendar_params
      params.require(:calendar).permit(:user_id, :sex_type, :feel_type, :condition_type, :ymd)
    end

  def calendar_params_new
      params.permit(:ymd)
  end

  def today_check
    d = params.permit(:ymd)
    @today = Calendar.find_by(ymd: d[:ymd])

    if @today.present?
      redirect_to edit_calendar_url(@today)
    end
  end

  def set_calendar_ym
    params.permit(:year,:month)
  end


end
