class StaticPagesController < ApplicationController

  load_and_authorize_resource #cancan

  def home
  end

  def about
  end

end
