class ShortlinksController < ApplicationController

  def new
    @link = Shortlink.new
  end

  def create
  end
end
