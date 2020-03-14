class AttendancesController < ApplicationController
  
  def new
    @user = User.find(params[:id])
    @attendance = @user.attendances.find_by(worked_on: Date.today)
    @first_day = first_day(params[:date])
    @last_day = @first_day.end_of_month
    @dates = user_attendances_month_date
  end
  
  def index
    @user = User.find(params[:id])
    @first_day = first_day(params[:first_day])
    @last_day = @first_day.end_of_month
    (@first_day..@last_day).each do |day|
      unless @user.attendances.any? {|attendance| attendance.worked_on == day}
        record = @user.attendances.build(worked_on: day)
        record.save
      end
    end
    @dates = user_attendances_month_date
    @worked_sum = @dates.where.not(started_at: nil).count
  end
  
  
  def edit
    @user = User.find(params[:id])
    @first_day = first_day(params[:date])
    @last_day = @first_day.end_of_month
    @dates = user_attendances_month_date
  end
  
  def create
    @user = User.find(params[:id])
    @attendance = @user.attendances.find_by(worked_on: Date.today)
    if @attendance.update_attributes(started_at:params[:started_at], finished_at:params[:finished_at], note:params[:note])
      @attendance.save
      redirect_to @user
    else
      render new_attendances_path
    end
  end
  
  def update
    @user = User.find(params[:id])
    attendances_params.each do |id, item|
      attendance = Attendance.find(id)
      attendance.update_attributes(item)
    end
    flash[:success] = '勤怠情報を更新しました。'
    redirect_to user_attendances_path
  end
    
  private
  
    def attendances_params
      params.permit(attendances: [:started_at, :finished_at, :note])[:attendances]
    end
end
