class Api::FilmsController < ApplicationController

    def index
      @films = Film.all
      @films = @films.order(id: :desc)
      render "index.json.jb"
    end

    def create
      @film = Film.new(
        title: params[:title],
        imdb_number: params[:imdb_number],
        thumbs_up: params[:thumbs_up],
        thumbs_down: params[:thumbs_down]
      )
      if @film.save
        render "show.json.jb"
      else
        render json: { errors: @film.errors.full_messages }, status: :bad_request
      end
    end

    def show
      @film = Film.find(params[:id])
      render "show.json.jb"
    end

    def update
      @film = Film.find(params[:id])
      @film.title = params[:title] || @film.title
      @film.imdb_number = params[:imdb_number] || @film.imdb_number
      @film.thumbs_up = params[:thumbs_up] || @film.thumbs_up
      @film.thumbs_down = params[:thumbs_down] || @film.thumbs_down
      if @film.save
        render "show.json.jb"
      else
        render json: { errors: @film.errors.full_messages }, status: :unprocessable_entity
      end
    end

    def destroy
      film = film.find(params[:id])
      film.destroy
      render json: { message: "film successfully destroyed!" }
    end

end
