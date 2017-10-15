class Taco < ActiveRecord::Base
  @@condiment_num = 2
  @@mixin_num = 3
  @@seasoning_num = 4
  belongs_to :user


  def populate(p)

    update_attribute(:shells, p["shells"].tr("_", " "))
    update_attribute(:baselayers, p["baselayers"].tr("_", " "))
    update_attribute(:mixin, p["mixins"].values.select{|ingredient| ingredient != "None"}.map{|ingredient| ingredient.tr("_", " ")}.uniq)
    update_attribute(:condiment,  p["seasonings"].values.select{|ingredient| ingredient != "None"}.map{|ingredient| ingredient.tr("_", " ")}.uniq)

  end
  def self.random
    url = "https://tacos-sayjfycwsy.now.sh/shells"
    shells = JSON.parse(open(url).read).sample["name"]
    url = "https://tacos-sayjfycwsy.now.sh/baselayers"
    baselayers = JSON.parse(open(url).read).sample["name"]
    url = "https://tacos-sayjfycwsy.now.sh/mixins"
    mix_in_choices = JSON.parse(open(url).read) << {"name" => "None"}
    mixins = [mix_in_choices.sample()["name"],  mix_in_choices.sample()["name"]]
    url = "https://tacos-sayjfycwsy.now.sh/seasonings"
    seasoning_choices = JSON.parse(open(url).read) << {"name" => "None"}
    puts(seasoning_choices)
    seasonings = [seasoning_choices.sample()["name"],  seasoning_choices.sample()["name"]]
    url = "https://tacos-sayjfycwsy.now.sh/condiments"
    condiment_choices = JSON.parse(open(url).read) << {"name" => "None"}
    condiments = [ condiment_choices.sample()["name"], condiment_choices.sample()["name"]]
    #@condiments = [{"0" => "", "val" => condiment_choices.sample()["name"]},{"1" => "", "val" => condiment_choices.sample()["name"]}]
    t = Taco.new
    t.update_attributes({:shells => shells, :baselayers => baselayers, :mixin => mixins, :condiment => condiments, :seasoning => seasonings})
    return t
  end
  def short_description
    puts("here it is")
    puts(self.description)

    s_description = self.description
    s_description.length > 50 ? "#{s_description[0...50]}..." : s_description
  end
  def description
    beginning = "A delicious taco made with a #{self.shells} shell with #{self.baselayers}, "
    last = ""
    self.mixin.each do |mixin|
        if last != ""
          beginning = beginning + last + ", "
        end
        last = mixin
    end
    self.seasoning.each do |seasoning|
        if last != ""
          beginning = beginning + last + ", "
        end
        last = seasoning
    end
    self.condiment.each do |condiment|
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
