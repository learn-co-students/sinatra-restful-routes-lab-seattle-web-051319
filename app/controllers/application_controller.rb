require 'pry'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/recipes' do 
    @recipes = Recipe.all
    erb :index
  end

  get '/recipes/new' do 

    erb :new
  end

  post '/recipes' do 
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  get '/recipes/:id' do 
    id = params[:id]
    @recipe = Recipe.find(id)
    erb :show
  end

  delete '/recipes/:id' do 
    id = params[:id]
    @recipe = Recipe.find(id)
    @recipe.delete

    redirect to '/recipes'
  end

  get '/recipes/:id/edit' do 
    id = params[:id]
    @recipe = Recipe.find(id)
    erb :edit
  end

  patch '/recipes/:id/edit' do 
    id = params[:id]
    @recipe = Recipe.find(id)
    @recipe.update(name: params[:name], ingredients: params[:ingredients], cook_time: params[:cook_time])
    redirect to "/recipes/#{id}"
  end


end
