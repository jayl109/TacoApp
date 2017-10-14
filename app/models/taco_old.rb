class Taco
  attr_accessor :shell
  attr_accessor :baselayers
  attr_accessor :mixin
  attr_accessor :condiment
  attr_accessor :seasoning
  def initialize(params)
    puts("here")
    @shell = params[:shells].tr("_", " ")
    @baselayers = params[:baselayers].tr("_", " ")
    @mixin = params[:mixins].values.select{|ingredient| ingredient != "None"}.map{|ingredient| ingredient.tr("_", " ")}.uniq
    @condiment = params[:condiments].values.select{|ingredient| ingredient != "None"}.map{|ingredient| ingredient.tr("_", " ")}.uniq
    @seasoning = params[:seasonings].values.select{|ingredient| ingredient != "None"}.map{|ingredient| ingredient.tr("_", " ")}.uniq
  end
  def self.random
    puts("gdi")
    url = "https://tacos-sayjfycwsy.now.sh/shells"
    @shells = JSON.parse(open(url).read).sample["name"]
    url = "https://tacos-sayjfycwsy.now.sh/baselayers"
    @baselayers = JSON.parse(open(url).read).sample["name"]
    url = "https://tacos-sayjfycwsy.now.sh/mixins"
    mix_in_choices = JSON.parse(open(url).read) << {"name" => "None"}
    @mixins = {"0" =>  mix_in_choices.sample()["name"],  "1" => mix_in_choices.sample()["name"]}
    url = "https://tacos-sayjfycwsy.now.sh/seasonings"
    seasoning_choices = JSON.parse(open(url).read) << {"name" => "None"}
    puts(seasoning_choices)
    @seasonings = {"0" => seasoning_choices.sample()["name"], "1" => seasoning_choices.sample()["name"]}
    url = "https://tacos-sayjfycwsy.now.sh/condiments"
    condiment_choices = JSON.parse(open(url).read) << {"name" => "None"}
    @condiments = {"0" => condiment_choices.sample()["name"], "1" => condiment_choices.sample()["name"]}

    #@condiments = [{"0" => "", "val" => condiment_choices.sample()["name"]},{"1" => "", "val" => condiment_choices.sample()["name"]}]
    puts("here")
    return Taco.new({:shells => @shells, :baselayers => @baselayers, :mixins => @mixins, :condiments => @condiments, :seasonings => @seasonings})
  end
  def short_description
    puts("here it is")
    puts(self.description)

    s_description = self.description
    s_description.length > 50 ? "#{s_description[0...50]}..." : s_description
  end
  def description
    beginning = "A delicious taco made with a #{@shell} shell with #{@baselayers}, "
    last = ""
    @mixin.each do |mixin|
        if last != ""
          beginning = beginning + last + ", "
        end
        last = mixin
    end
    @seasoning.each do |seasoning|
        if last != ""
          beginning = beginning + last + ", "
        end
        last = seasoning
    end
    @condiment.each do |condiment|
        if last != ""
          beginning = beginning + last + ", "
        end
        last = condiment
    end
    if last != ""
      return beginning+"and #{last}."
    else
      return beginning
    end
  end
end
