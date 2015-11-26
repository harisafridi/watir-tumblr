require 'watir-webdriver'
require 'yaml'
$LOAD_PATH << '.'
require "utiltumblr"

class Browser_Initialize
   browser = Watir::Browser.new :firefox
   browser.goto "http://tumblr.com/login"
   data = YAML.load(File.open('form.yml'))
   email = data['email']
   password = data["password"]
   include UtilTumblr
   Browser_Initialize.new.login(email, password, browser)
   Browser_Initialize.new.post_blog(browser)
   Browser_Initialize.new.verify_blog(browser)
   Browser_Initialize.new.delete_blog(browser)
   browser.close
end
