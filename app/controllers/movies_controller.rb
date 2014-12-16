# This file is app/controllers/movies_controller.rb
class MoviesController < ApplicationController

  def index
    @sort_by = params[:sort]
    @all_ratings = Movie.ratings
    @selected_ratings = @all_ratings

    if params[:commit] == 'Refresh'
      @selected_ratings = []
      params[:ratings].each_key { |k| @selected_ratings.push(k)} if not params[:ratings].nil?
    end
    @movies = Movie.where("rating" => @selected_ratings).order(@sort_by)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # Look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
