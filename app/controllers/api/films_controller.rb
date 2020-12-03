class Api::FilmsController < ApplicationController

    def search
      title = params[:title]
      movies = HTTParty.get("https://movie-database-imdb-alternative.p.rapidapi.com?s=#{title}&page=1&r=json", {
        headers: {
          'x-rapidapi-key' => 'e979f7406cmsh363d1f98423c118p197d7bjsnce1e962638fd',
          'x-rapidapi-host' => 'movie-database-imdb-alternative.p.rapidapi.com'
        }
      })
      @films = Film.all
      movies['Search'].each do |movie| 
        movie['thumbs_up'] = 0
        movie['thumbs_down'] = 0
        movie['db_id'] = nil
        @films.each do |film|
          if film.imdb_number == movie['imdbID']
            movie['thumbs_up'] = film.thumbs_up
            movie['thumbs_down'] = film.thumbs_down
            movie['db_id'] = film.id
          end 
        end 
      end 
        puts movies
        render json: movies['Search']
    end 

    def index
      @films = Film.all
      @films = @films.order(id: :desc)
      render "index.json.jb"
    end

    def create
      @film = Film.new(
        title: params[:title],
        imdb_number: params[:imdb_number],
        thumbs_up: 0,
        thumbs_down: 0
      )
      if params[:rating] == "thumbs_up"
        @film.thumbs_up += 1
      elsif params[:rating] == "thumbs_down"
        @film.thumbs_down += 1
      end 
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
      @film = Film.find_by(imdb_number: params[:imdb_number])
      unless @film 
        @film = Film.new(
          title: params[:title],
          imdb_number: params[:imdb_number],
          thumbs_up: 0,
          thumbs_down: 0
        )
      end
      if params[:rating] == "thumbs_up"
        @film.thumbs_up += 1
      elsif params[:rating] == "thumbs_down"
        @film.thumbs_down += 1
      end 
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
