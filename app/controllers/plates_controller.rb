class PlatesController < ApplicationController

  get "/plates/new" do 
    if logged_in?
      erb :"plates/new"
    else
      flash[:error] = "Cant create a meal if not logged in"
      redirect "/login"
    end
  end

  post "/plates" do 
    
    if !params[:plate].empty?
      @plate = Plate.create(params[:plate])
      redirect "/users/#{@plate.user_id}"
    else
      flash[:error] = "Sorry looks like your not logged in"
      redirect "/login"
    end
  end

  get "/plates/:id" do 
    
    if logged_in?
        @plate = Plate.find(params[:id])
        erb :"plates/show"
    else
        redirect "/login"
    end
  end

  get "/plates/:id/edit" do 
    binding.pry
      if_not_yours
      if logged_in? 
        @plate = Plate.find_by_id(params[:id])
        if @plate && @plate.user_id == current_user.id
        erb :"plates/edit"
        else
          redirect "/login"
        end
      else
        redirect "/login"
      end
  end

  patch "/plates/:id" do

     plate = Plate.find(params[:id])
     if plate.user_id && plate.user_id == current_user.id
      plate.update(params[:plate])
      redirect "/plates/#{plate.id}"
     else
      redirect "/plates/#{plate.id}/edit"
     end
  end

  delete "/plates/:id" do 
    
      if_not_yours
      meal = Plate.find(params[:id])
      if logged_in? && meal.user_id == current_user.id
        meal.delete
        redirect "/users/#{meal.user_id}"
      else
        redirect "/users/#{current_user.id}"
      end
  end

end
