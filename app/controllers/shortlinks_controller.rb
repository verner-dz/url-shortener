class ShortlinksController < ApplicationController
  include UrlCodec

  def new
    @link = Shortlink.new
  end

  def create
    last_id = Shortlink.last.try(:id) || 0
    shortlink = Shortlink.find_by_destination(params[:shortlink][:destination])

    if shortlink.nil?
      slug = UrlCodec.encode(last_id + 1)
      @link = Shortlink.new(shortlink_params)
      @link.slug = slug
    else
      @link = shortlink
    end

    respond_to do |format|
      if @link.save
        url = request.base_url + "/" + @link.slug
        format.js { render :create, locals: { url: url, new_link: Shortlink.new } }
      else
        format.js { render :errors, locals: { link: @link }}
      end
    end
  end

  private

  def shortlink_params
    params.require(:shortlink).permit(:destination)
  end
end
