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
    
    browser = Browser.new(:ua => request.user_agent)
    if browser.firefox?
      Short.increment_counter :firefox, short.id
    elsif browser.chrome?
      Short.increment_counter :chrome, short.id
    elsif browser.ie?
      Short.increment_counter :ie, short.id
    elsif browser.opera?
      Short.increment_counter :opera, short.id
    elsif browser.safari?
      Short.increment_counter :safari, short.id
    elsif browser.other?
      Short.increment_counter :other, short.id
    end
    

    redirect_to "#{short.longer}"
#    respond_to do |format|
#      format.html { redirect_to "#{short.longer}" }
#    end
  end
end
