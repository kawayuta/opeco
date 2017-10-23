class SharesController < ApplicationController

  before_action :set_shares, only: [:destroy]
  before_action :new_shares_check, only: [:new]
  before_action :authenticate_user!

  def index
    @shares = Share.where(user_id: current_user).or(Share.where(partner_user_id: current_user))
  end

  def new
    @share = current_user.share.new
  end


  def create
    @share = current_user.share.new(share_params)
    @search_partner = User.find_by(username: @share.username)

    if @search_partner.present?
      if current_user.share.find_by(partner_user_id: @search_partner.id).present?
      @invite = current_user.share.find_by(partner_user_id: @search_partner.id)
      end
    end

    if @search_partner.present? && @search_partner != current_user && @invite.present? == false
        @share.partner_user_id = @search_partner.id
        respond_to do |format|
          if @share.save
            format.html { redirect_to calendars_path, notice: "#{@share.username}さんに共有招待をおくりました。" }
            format.json { render :show, status: :created, location: @share }
          else
            format.html { render :new }
            format.json { render json: @share.errors, status: :unprocessable_entity }
          end
        end

     elsif @search_partner == current_user
       flash[:notice] = "#{@share.username}さんはあなたです。"
       redirect_to new_share_path
     elsif @invite.present?
       flash[:notice] = "#{@share.username}さんは招待済みです。"
       redirect_to new_share_path
    else
       flash[:notice] = "#{@share.username}さんは見つかりませんでした。"
       redirect_to new_share_path
    end

  end


  def update
    respond_to do |format|
      if @share.update(share_update_params)
        format.html { redirect_to calendars_path, notice: '今日のデータを更新しました。' }
        format.json { render :show, status: :ok, location: @share }
      else
        format.html { render :edit }
        format.json { render json: @share.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destory
    @share.destroy
    respond_to do |format|
      format.html { redirect_to calendars_url, notice: 'Calendar was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def change
    @share = Share.find(params[:id])
    if @share.share_flag == true
      @share.share_flag = false
      respond_to do |format|
        if @share.save
          format.html { redirect_to shares_path, notice: '共有を中止しました' }
          format.json { render :index, status: :ok, location: @share }
        else
          format.html { render :edit }
          format.json { render json: @share.errors, status: :unprocessable_entity }
        end
      end
    else
      @share.share_flag = true
      respond_to do |format|
        if @share.save
          format.html { redirect_to shares_path, notice: '共有を開始しました' }
          format.json { render :index, status: :ok, location: @share }
        else
          format.html { render :edit }
          format.json { render json: @share.errors, status: :unprocessable_entity }
        end
      end
    end

  end
  private

  def share_params
    params.require(:shares).permit(:user_id, :username)
  end

  def share_update_params
    params.require(:shares).permit(:share_flag)
  end

  def set_shares
    @share = Share.find(params[:id])
  end

  def new_shares_check
    puts current_user.gender
    if current_user.gender == 'male'
      redirect_to shares_path
      flash[:notice] = "パートナーからの招待が必要です。"
    end
  end
end
