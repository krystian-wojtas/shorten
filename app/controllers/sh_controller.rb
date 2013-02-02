class ShController < ApplicationController
  def index
    @short = Short.new
  end

  def create
    @short = Short.new(params[:short])

    respond_to do |format|
      if @short.save
        format.html { redirect_to show_short_path(:short => @short.shorter) }
        format.json { render json: @short, status: :created, location: @short }
      else
        format.html { render action: "index" }
        format.json { render json: @short.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @short = Short.where('shorter = ?', params[:short]).first
  end

  def redirect
    short = Short.where('shorter = ?', params[:short]).first
    short.stat.up( request.user_agent )
    
    redirect_to "#{short.longer}"
#    respond_to do |format|
#      format.html { redirect_to "#{short.longer}" }
#    end
  end
end
