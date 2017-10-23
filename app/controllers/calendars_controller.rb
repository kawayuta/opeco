class CalendarsController < ApplicationController
  require 'date'
  before_action :set_calendar, only: [:show, :edit, :update, :destroy]
  after_action :database_status_update, only: [:create, :edit, :update, :destroy]
  before_action :today_check, only: [:new]
  before_action :set_calendar_ym, only: [:index]
  before_action :authenticate_user!

  # GET /calendars
  # GET /calendars.json
  def index

    @now = Time.current
    @today = Date.today
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
    @calendars = current_user.calendar.where(created_at: @now.beginning_of_month..@now.end_of_month, user_id: current_user.id)

    if current_user.calendar.find_by("DATE(ymd) = '#{@now.to_time.strftime('%Y-%m-%d')}'").present? == true
      @calendar = current_user.calendar.find_by("DATE(ymd) = '#{@now.to_time.strftime('%Y-%m-%d')}'")
    else
      @calendar = current_user.calendar.new(calendar_params_new)
    end




    if current_user.gender == 'male'
      @girl_friend = Share.where(partner_user_id: current_user, share_flag: true).pluck(:user_id)
      @girl_friend_data = Calendar.where(user_id: @girl_friend)
      @girl_friend_database = []

      @my_status = Status.find_by(user_id: @girl_friend)
    else
      @my_status = current_user.status
    end

    if @my_status.present? == true

      @next_hairan_schedule = []
      @next_hairan_schedule.push((@my_status.next_hairan.to_date - 3).strftime("%Y-%m-%d"))
      @next_hairan_schedule.push((@my_status.next_hairan.to_date - 2).strftime("%Y-%m-%d"))
      @next_hairan_schedule.push((@my_status.next_hairan.to_date - 1).strftime("%Y-%m-%d"))
      @next_hairan_schedule.push((@my_status.next_hairan.to_date + 1).strftime("%Y-%m-%d"))
      @next_hairan_schedule.push((@my_status.next_hairan.to_date + 2).strftime("%Y-%m-%d"))
      @next_hairan_schedule.push((@my_status.next_hairan.to_date + 3).strftime("%Y-%m-%d"))

      @next_seiri_schedule = []
      @next_seiri_schedule.push((@my_status.next_seiri.to_date - 1).strftime("%Y-%m-%d"))
      @next_seiri_schedule.push((@my_status.next_seiri.to_date + 1).strftime("%Y-%m-%d"))

      @countdown_seiri = @my_status.next_seiri.to_date - @today
      @countdown_hairan = @my_status.next_hairan.to_date - @today

    end


  end

  # GET /calendars/1
  # GET /calendars/1.json
  def show

    puts @calendar.feel_type
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
    @now = Time.current

      @calendar = current_user.calendar.new(calendar_params)
      unless @calendar.ymd.present?
        @calendar.ymd = @now.strftime("%Y-%m-%d")
      end
      respond_to do |format|
        if @calendar.save
          format.html { redirect_to calendars_path, notice: '今日のデータを登録しました。' }
          format.json { render :show, status: :created, location: @calendar }
        else
          format.html { render :new }
          format.json { render json: @calendar.errors, status: :unprocessable_entity }
        end
      end

  end

  # PATCH/PUT /calendars/1
  # PATCH/PUT /calendars/1.json
  def update
    respond_to do |format|
      if @calendar.update(calendar_params)
        format.html { redirect_to calendars_path, notice: '今日のデータを更新しました。' }
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
      format.html { redirect_to calendars_url, notice: '今日のデータを削除しました' }
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
    @today = current_user.calendar.find_by(ymd: d[:ymd])

    if @today.present?
      redirect_to edit_calendar_url(@today)
    end
  end

  def set_calendar_ym
    params.permit(:year,:month)
  end


  def database_status_update
    last_end_seiri_record = current_user.calendar.where(condition_type: 1).order(:ymd).last

    if last_end_seiri_record.present? == true

      last_seiri_day = last_end_seiri_record.ymd.strftime("%Y-%m-%d").split("-")
      last_seiri = Date.new(last_seiri_day[0].to_i,last_seiri_day[1].to_i,last_seiri_day[2].to_i)

      last_start_seiri_record = current_user.calendar.where("condition_type = 1 and DATE(ymd) between ? and ?", last_seiri.strftime("%Y-%m") + "-1", last_seiri.strftime("%Y-%m") + "-31").order(:ymd).first

      before_month_seiri = last_seiri << 1
      before_month_seiri_record = current_user.calendar.where("condition_type = 1 and DATE(ymd) between ? and ?", before_month_seiri.strftime("%Y-%m") + "-1",before_month_seiri.strftime("%Y-%m") + "-31").order(:ymd).last


      last_seiri_count = current_user.calendar.where("condition_type = 1 and DATE(ymd) between ? and ?", last_seiri.strftime("%Y-%m") + "-1", last_seiri.strftime("%Y-%m") + "-31").count


      @next_seiri = last_seiri + 28
      @next_hairan = @next_seiri - ((28 - 14) - last_seiri_count.to_i)

      if before_month_seiri_record.present? == true

        before_month_seiri_array = before_month_seiri_record.ymd.strftime("%Y-%m-%d").split("-")
        last_month_seiri_array = last_start_seiri_record.ymd.strftime("%Y-%m-%d").split("-")
        before_month_seiri_array_data = Date.new(before_month_seiri_array[0].to_i,before_month_seiri_array[1].to_i,before_month_seiri_array[2].to_i)
        last_month_seiri_array_data = Date.new(last_month_seiri_array[0].to_i,last_month_seiri_array[1].to_i,last_month_seiri_array[2].to_i)

        @user_next_seiri = before_month_seiri_array_data - last_month_seiri_array_data

        if @user_next_seiri.to_i.abs <= 25
          @next_seiri = last_seiri + 28
          if last_seiri_count.to_i > 0
            @next_hairan = @next_seiri - ((28 - 14) - last_seiri_count.to_i)
          else
            @next_hairan = @next_seiri - ((28 - 14) - 5)
          end
        else
          @next_seiri = last_seiri + @user_next_seiri.to_i.abs
          if last_seiri_count.to_i > 0
            @next_hairan = @next_seiri - ((@user_next_seiri.to_i.abs - 14) - last_seiri_count.to_i)
          else
            @next_hairan = @next_seiri - ((@user_next_seiri.to_i.abs- 14) - 5)
          end
        end

      end

      if current_user.status
        @status = current_user.status
      else
        @status = current_user.build_status
      end
      @status.update(next_seiri: @next_seiri, next_hairan: @next_hairan, ninsin_possibility:"", uranai:"", notice:"")

    end
  end


end
