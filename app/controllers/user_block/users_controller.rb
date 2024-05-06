class UserBlock::UsersController < ApplicationController

    #if you want to store data in google sheet then first create the file using google sheet api

    def create
      user = UserBlock::User.new(user_params)
      if user.save
        url = UserBlock::User.enter_data(user.id, user.name, user.email, user.age, params[:file_name]) if params[:file_name].present?
        render json: {user: user, url: url.human_url, message: "User created"}
      else
        render json: {message: "Failed to create User", errors: user.errors},status: 422
      end
    end 

    def update
      user = UserBlock::User.find(params[:id])
      user.update(user_params)
      url = UserBlock::User.update_user_data(user.id, user.name, user.email, user.age, params[:file_name]) if params[:file_name].present?
      render json: { data: user, url: url.human_url }
    end


    def destroy
       user = UserBlock::User.find(params[:id])
       user.destroy
       url = UserBlock::User.remove_user_data(user.id, params[:file_name]) if params[:file_name].present?   
       render json: { data: user, url: url.human_url }
    end

    private

    def user_params
    	params.permit(:name, :email, :password, :age)

    end




end