class Taco < ActiveRecord::Base
  @@condiment_num = 2
  @@mixin_num = 3
  @@seasoning_num = 4
  belongs_to :user
  def self.condiment_num
    return @@condiment_num
  end
  def self.mixin_num
    return @@mixin_num
  end
  def self.seasoning_num
    return @@seasoning_num
  end

  #takes in a hash, and inserts those values into the taco
  def populate(p)

    update_attribute(:shells, p["shells"].tr("_", " "))
    update_attribute(:baselayers, p["baselayers"].tr("_", " "))
    update_attribute(:mixin, p["mixins"].values.select{|ingredient| ingredient != "None"}.map{|ingredient| ingredient.tr("_", " ")}.uniq)
    update_attribute(:condiment,  p["seasonings"].values.select{|ingredient| ingredient != "None"}.map{|ingredient| ingredient.tr("_", " ")}.uniq)

  end
  #generates a random taco and returns it (saves it as well, but doesnt connect it to the user)
  def self.random
    url = "https://tacos-sayjfycwsy.now.sh/shells"
    shells = JSON.parse(open(url).read).sample["name"]
    url = "https://tacos-sayjfycwsy.now.sh/baselayers"
    baselayers = JSON.parse(open(url).read).sample["name"]
    url = "https://tacos-sayjfycwsy.now.sh/mixins"
    mix_in_choices = JSON.parse(open(url).read) << {"name" => "None"}
    mixins = []
    @@mixin_num.times do
      mixins << mix_in_choices.sample()["name"]
    end
    url = "https://tacos-sayjfycwsy.now.sh/seasonings"
    seasoning_choices = JSON.parse(open(url).read) << {"name" => "None"}
    seasonings = []
    @@seasoning_num.times do
      seasonings << seasoning_choices.sample()["name"]
    end
    url = "https://tacos-sayjfycwsy.now.sh/condiments"
    condiments = []
    condiment_choices = JSON.parse(open(url).read) << {"name" => "None"}

    @@condiment_num.times do
      condiments << condiment_choices.sample()["name"]
    end
    t = Taco.new
    t.update_attributes({:shells => shells, :baselayers => baselayers, :mixin => mixins, :condiment => condiments, :seasoning => seasonings})
    return t
  end
  #provides a shorter description (for table viewing purposes)
  def short_description
    puts("here it is")
    puts(self.description)

    s_description = self.description
    s_description.length > 50 ? "#{s_description[0...50]}..." : s_description
  end
  #returns a description of the taco you made
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
