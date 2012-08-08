ENV["RAILS_ENV"] ||= 'development'
require File.expand_path("../../config/environment", __FILE__)

require 'capybara'
require 'capybara/dsl'

Capybara.current_driver = :selenium
Capybara.app_host = 'http://www.wg-gesucht.de'

loop do
  sleep(10)
  begin 
    runner = Runner.new
    runner.start
  rescue Exception => e
    Runner.save
    p e
  end
end
