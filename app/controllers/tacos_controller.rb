require 'open-uri'
class TacosController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_action :authenticate_user!


  def index
   @tacos = current_user.tacos
  end
  def delete
    @taco = Taco.find(params[:id])
    @taco.destroy
    redirect_to "/"
  end
  def create
    #taco = Taco.new(params[:shells].tr("_") ,params[:baselayers], params[:mixins],  params[:condiments], params[:seasonings])
    taco = Taco.new()
    taco.populate(params)
    puts("here")
    puts(taco.shells)
    taco.save
    puts("saved")
    current_user.tacos << taco
    puts("added")
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
    taco = Taco.random
    current_user.tacos << taco

    redirect_to "/"
    return

  end
  def view
    @taco = Taco.find(params[:id])
  end
end
