class GoalsController < ApplicationController
    
    get "/goals" do
        if current_user.goals != []
            @user_goals = current_user.goals.all
        end
        @goals = Goal.all
        erb :"goals/index"
    end

    get "/goals/new" do #NEW ACTION
        @user = User.find(session[:user_id])
        erb :"goals/new"
    end

    post "/goals" do
        @goals = Goal.new(goal_name: params[:goal_name],goal_type: params[:goal_type], goal_details: params[:goal_details], obstacles: params[:obstacles], user_id: current_user.id) 
        if @goals.save
            redirect "/goals/:id" 
        else 
            redirect "/goals/new" 
        end                         
    end
    
    get "/goals/:id/edit" do #EDIT ACTION
        @user = User.find(session[:user_id])
        @goal = Goal.find_by_id(params[:id])
        if @goal.user_id == current_user.id
            erb :"goals/edit"
        else
            redirect "/goals"
        end
    end

    patch "/goals/:id" do #UPDATE ACTION
        
        @goal = Goal.find_by_id(params[:id])
        params.delete("_method")
        if @goal.update(params)
            redirect "/goals/#{@goal.id}"
        else
            redirect "/goals/#{@goal.id}/edit"
        end
    end
        
    get "/goals/:id" do #SHOW ACTION
        @current_user = User.find(session[:user_id])
        @goal = Goal.find_by_id(params[:id])
        erb :"goals/show"                      
    end 

    delete "/goals/:id" do #DELETE ACTION
        @goal = Goal.find_by_id(params[:id])
        if @goal = user_id == current_user.id
            @goal.destroy
            redirect "/goals"
        else
            redirect "/goals"
        end
    end
end
