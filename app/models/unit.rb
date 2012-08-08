require 'capybara/dsl'
class Unit < ActiveRecord::Base
  include Capybara::DSL
  attr_accessible :applied, :content, :link, :wg_id
 
  after_save :apply
  before_validation :make

  validates_presence_of :link
  validates_uniqueness_of :wg_id
  validates_presence_of :wg_id

  def apply 
    visit link 
    find(".nachricht-senden-icon-rhs-en").click
    sex if sex?
    fill_in "nachricht", :with => "something"
    has_selector?("input[src='img/lang/en/buttons/nachricht_senden.gif']")
  end 

  def make
    self.wg_id = link.split(".")[3]
  end

  def sex?
    has_selector?("input#sicherheit_bestaetigung")
  end

  def sex
    choose "geschlecht_m"
    click_on "sicherheit_bestaetigung"
    #has_selector?("input[type='image',name='submitted']")
  end
end
