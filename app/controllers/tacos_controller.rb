require 'open-uri'
class TacosController < ApplicationController
  skip_before_filter :verify_authenticity_token
  rescue_from ActionDispatch::Cookies::CookieOverflow :with => :warn_and_redirect
  def warn_and_redirect
    flash[:message] = "You cant make more tacos, delete one first!"
    redirect_to "/"
  end
  def index
   @tacos = session[:tacos]
   puts(@tacos)
  end
  def delete
    tacos = session[:tacos]
    tacos.delete_at(params[:taco].to_i)

    session[:tacos] = tacos

    redirect_to "/"
  end
  def create
    #taco = Taco.new(params[:shells].tr("_") ,params[:baselayers], params[:mixins],  params[:condiments], params[:seasonings])
    taco = Taco.new(params)
    puts("taco is #{taco}")

      if session[:tacos] == nil
        session[:tacos] = [taco.to_yaml]
      else
        session[:tacos] << taco.to_yaml
      end




    redirect_to "/"
    return
  end
  def show
    redirect_to "/"
  end
  def new

    url = "https://tacos-sayjfycwsy.now.sh/shells"
    @shells = JSON.parse(open(url).read)
    url = "https://tacos-sayjfycwsy.now.sh/baselayers"
    @baselayers = JSON.parse(open(url).read)
    url = "https://tacos-sayjfycwsy.now.sh/mixins"
    @mixins = JSON.parse(open(url).read)
    url = "https://tacos-sayjfycwsy.now.sh/seasonings"
    @seasonings = JSON.parse(open(url).read)
    url = "https://tacos-sayjfycwsy.now.sh/condiments"
    @condiments = JSON.parse(open(url).read)
  end
  def random
    puts("ja")
    taco = Taco.random
    puts(taco)
    begin
      if session[:tacos] == nil
        session[:tacos] = [taco.to_yaml]
      else
        session[:tacos] << taco.to_yaml
      end
    rescue CookieOverflow
      flash[:message] = "You cannot store any more tacos, delete one first!"
    end
    redirect_to "/"
    return

  end
  def view
    @taco = YAML.load(session[:tacos][params[:index].to_i])
  end
end
