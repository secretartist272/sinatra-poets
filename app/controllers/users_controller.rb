class UsersController < ApplicationController
    
    #create login
    get '/login' do
        redirect_if_logged_in
        erb :login
    end

    post '/login' do
        @user = User.find_by(username: params[:username])

        if @user && @user.authenticate(params[:password])
            session[:user_id]
            redirect "users/#{@user.id}"
        else
            redirect '/login'
        end
    end

    #create users action:
    get '/signup' do
        redirect_if_logged_in
        erb :signup
    end

    post '/signup' do
        @user = User.new(params["user"])

        if @user.save
            session[:user_id] = @user.id 
            redirect "/users/#{@user.id}"
        else
            redirect '/signup'
        end
    end

    

    #show users actions
    get '/users/:id' do
        @user = User.find_by(id: params[:id])
        redirect_if_not_logged_in

        erb :"/users/show"
    end

    post '/users/:id' do
        @user = User.find_by_id(params[:id])
        erb :"/users/show"
    end
    
     #user delete action
     delete '/user/:id' do
        @user = User.find_by_id(params[:id])
        if @user
            @user.destroy
        else
            redirect to "/"
        end
     end

     get '/logout' do
         session.clear
         redirect '/'
     end

    #helper method
    def login
        User.find_by(id: session[:user_id])
    end

end