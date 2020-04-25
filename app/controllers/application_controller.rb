require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "secret"
    set :method_override, true
  end

  get "/" do
    redirect_if_logged_in
    redirect "/login"
  end

  helpers do

    def logged_in?
      session[:user_id]
    end

    def current_user
      User.find_by_id(session[:user_id])
    end

    def redirect_if_not_logged_in
      if !logged_in?
        redirect "/login"
      end
    end

    def redirect_if_logged_in
      if logged_in?
        redirect "/goals"
      end
    end
  end

end
