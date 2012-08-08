require 'capybara/dsl'
class Runner
  include Capybara::DSL
  extend Capybara::DSL
  
  def self.save
    save_and_open_page
  end
 
  def load_login
    @login_data || YAML::load_file(Rails.root.join('config','wg.yml'))
  end

  def logged?
    has_selector?("a[href='http://www.wg-gesucht.de/en/logout.html']")
  end
   
  def start
    login unless self.logged?
    filters
    read.each { |unit| Unit.new(:link => unit).save }
  end
   
  def login
    visit "/mein-wg-gesucht.html"
    fill_in "email", :with => load_login["login"]
    fill_in "passwort", :with => load_login["password"]
    find(".login_sprite").click 
  end

  def day_today
    Time.now.day < 10? "0#{Time.now.day}":"#{Time.now.day}"
  end
  def filter_date
     find("img[alt='Filter']").click
     select day_today, :from => "frei_ab_Day"
     select "August", :from => "frei_ab_Month"
     #select "2012", :from => "frei_ab_Year" # year is already set and didnt work
     select "15", :from => "frei_bis_Day"
     select "September", :from => "frei_bis_Month"
     #select "2012", :from => "frei_bis_Month"  
  end

  def filter_location
     find("img[alt='Stadtteile / Umkreis']").click # select location
     check "ot[2737]" # stuttgart west
  end

  def filters
    visit "/en/wg-zimmer-in-Stuttgart.124.0.0.0.html" 
    # rent type - 1 short term, 2 long term
    #select "2", :from => "mieteart"
    filter_location
    filter_date
    #do the filter
    find("input.filtern-as-en").click
  end

  def read
    all("td.ang_spalte_icons").map { |td| td.find("a")["href"] }.reject{ |l| l =~ /.*immobilienscout24.de.*/ }
  end
end
