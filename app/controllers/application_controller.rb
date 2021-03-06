require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    register Sinatra::Flash
  end

  get "/" do
    erb :intro
  end

  helpers do 

    def logged_in?
      !!session[:user_id]
      
    end
    
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def if_not_yours
          flash[:message] = "sorry that was not your plate here are your plates"
          redirect "/users/<%=current_user.id%>" if !current_user
    end

  end

  

end
