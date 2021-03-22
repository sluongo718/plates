class UsersController < ApplicationController


  get "/signup" do 
    
    if logged_in?
      user = User.find_by(params[:user])
      redirect "/users/#{user.id}"
    else

        erb :signup
    end
  end

  post "/signup" do 
   
    newu = User.find_by_username(params[:user][:username]).present?
      if !params[:user][:username].empty? && !params[:user][:password].empty? && !newu
        user = User.new(params[:user])
        user.save
        session[:user_id] = user.id
        redirect to "/users/#{user.id}"
      else
        erb :"signup"
      end
  end

  get "/login" do 

    if !logged_in?
    erb :"/login"
    else
      redirect "/users/#{current_user.id}"
    end
  end

  post "/login" do 
      @user = User.find_by(username: params[:user][:username])
      if @user && @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        redirect "/users/#{@user.id}"
      else
        flash[:error] = "Sorry Mate, looks like something was wroning with your info."
          redirect "/login"
      end
  end

  get '/users/:id' do 
    
    if logged_in?
    @user = User.find_by_id(params[:id])
    @plates = @user.plates
    erb :'users/show'
    else

      redirect "/login"
    end
  end

  get "/logout" do 
    session.destroy
    redirect "/signup"
  end


end
