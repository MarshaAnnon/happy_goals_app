class GoalsController < ApplicationController
    
    get "/goals" do
        redirect_if_not_logged_in
        if current_user.goals != []
            @user_goals = current_user.goals.all
        end
        @goals = Goal.all
        erb :"goals/index"
    end

    get "/goals/new" do 
        redirect_if_not_logged_in
        @user = User.find(session[:user_id])
        erb :"goals/new"
    end

    post "/goals" do
        @goals = current_user.goals.build(params)
        if @goals.save
            redirect "/goals/#{@goals.id}" 
        else 
            redirect "/goals/new" 
        end                         
    end
    
    get "/goals/:id/edit" do 
        redirect_if_not_logged_in
        @user = User.find(session[:user_id])
        @goal = Goal.find_by_id(params[:id])
        if @goal.user.id = current_user.id
            erb :"goals/edit"
        else
            redirect "/goals"
        end
    end

    patch "/goals/:id" do 
        @goal = Goal.find_by_id(params[:id])
        params.delete("_method")
        if @goal.update(params)
            redirect "/goals/#{@goal.id}"
        else
            redirect "/goals/#{@goal.id}/edit"
        end
    end
        
    get "/goals/:id" do 
        redirect_if_not_logged_in
        @user_goals = current_user.goals.all
        @goal = Goal.find_by_id(params[:id])
        erb :"goals/show"                      
    end 

    delete "/goals/:id" do 
        @goal = Goal.find_by_id(params[:id])
        if @goal.user.id = current_user.id
            @goal.destroy
            redirect "/goals"
        else
            redirect "/goals"
        end
    end
    
end
