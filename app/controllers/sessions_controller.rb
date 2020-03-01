class SessionsController < ApplicationController
  def new
  
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:success] ="ログインに成功しました"
      redirect_back_or user
    else
      flash.now[:danger] ="メールアドレス、又はパスワードが間違っています"
      render "new"
    end
  end
  
  def destroy
    log_out
    flash[:danger] ="ログアウトしました"
    redirect_to root_path
  end
  
end
