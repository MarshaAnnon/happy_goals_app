class UsersController < ApplicationController

    get "/signup" do #NEW ACTION
        erb :"users/signup"
    end

    post "/users" do #NEW ACTION
        @user = User.new(params)
        if @user && @user.save
            session[:user_id] == @user.id
            redirect "/goals"
        else
            erb :"users/signup"
        end
    end

end