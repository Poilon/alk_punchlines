# Artists controller
class ArtistsController < ApplicationController
  def index
    redirect_to [Artist.first, :punchlines]
  end
end
