require 'watir-webdriver'
require 'yaml'

module UtilTumblr
        def login (email, password, browser)    
         browser.text_field(name: 'user[email]').when_present.set("#{email}")
         browser.text_field(name: 'user[password]').when_present.set("#{password}")
         browser.button(id: 'signup_forms_submit').click
        end
        def post_blog(browser)
          browser.element(class: 'icon_post_text').click
          text = browser.element(class: 'editor-plaintext')
          text.send_keys("Title here\tparagraph here")
        end
        def verify_blog(browser)
          post_button = browser.button(class: "create_post_button").click
          post_body = browser.elements(class: "post_body")
          found = false
          post_body.each do |o| 
               if (o.text).match /paragraph here/
                  puts "Found! \n Your post is: #{o.text}" 
                  found = true 
               end
            end
          print "not found" if found == false
        end
end
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
   browser.close
end
