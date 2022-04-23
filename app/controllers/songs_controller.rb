class SongsController < ApplicationController
  # index - gets data for index page = all of the songs to list
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

  def new
    @song = Song.new
    3.times { @song.notes.build }
  end

  def create
    @song = Song.new(song_params)
    artist = Artist.find_or_create_by(name: song_params[:artist_name])
    @song.artist = artist

    if @song.save
      redirect_to @song
    else
      render :new
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])

    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    @song = Song.find(params[:id])
    @song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :artist_name, :genre_id, :note_contents => [])
  end
end


# :notes_contents => []if the parameter name contaisn an empty set of square brackets they will be accumulated into an array

