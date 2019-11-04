class ShortlinksController < ApplicationController
  def new
    @link = Shortlink.new
  end

  def create
    last_id = Shortlink.last.try(:id) || 0
    shortlink = Shortlink.find_by_destination(params[:shortlink][:destination])

    if shortlink.nil?
      @link = Shortlink.new(shortlink_params)
      @link.slug = @link.generate_slug(last_id)
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

  def find_and_redirect
    shortlink = Shortlink.find_by_slug(params[:slug])
    redirect_to shortlink.destination
  rescue
    not_found
  end

  private

  def shortlink_params
    params.require(:shortlink).permit(:destination)
  end
end
