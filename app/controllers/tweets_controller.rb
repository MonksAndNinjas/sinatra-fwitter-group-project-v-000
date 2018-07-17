require './config/environment'

class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.is_logged_in?(session)
      @current_user = User.find_by_id(session[:user_id])

      erb :'/tweets/index'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.is_logged_in?(session)
      @current_user = User.find_by_id(session[:user_id])

      erb :'/tweets/new'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])

    erb :'/tweets/show'
  end

  get '/tweets/:id/edit' do
    @tweet = Tweet.find_by_id(params[:id])

    erb :'/tweets/edit'
  end

  post '/tweets' do
    if !params[:content].empty?
      @current_user = User.find_by_id(session[:user_id])
      @current_user.tweets << Tweet.new(params)
      @current_user.save
    end

    redirect to '/tweets'
  end

  patch '/tweets/:id' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(content: params[:content])
    @tweet.save

    redirect to "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete

    redirect to '/tweets'
  end

end
