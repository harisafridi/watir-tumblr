require 'watir-webdriver'
require 'yaml'


browser = Watir::Browser.new :firefox
browser.goto "http://tumblr.com/login"


email = ''
password = ''

data = YAML.load(File.open('form.yml'))
 data['credentials'].each do |yaml|
 email = yaml['email']
 password = yaml["password"]
 end


def login (email, password, browser)
browser.text_field(name: 'user[email]').set("#{email}")
browser.text_field(name: 'user[password]').set("#{password}")
end

login(email,password, browser)

browser.button(id: 'signup_forms_submit').click

browser.element(class: 'icon_post_text').click
text =browser.element(class: 'editor-plaintext')
text.send_keys("Title here\tparagraph here")


post_button = browser.button(class: "create_post_button").click

post_body = browser.elements(class: "post_body")
found = false
post_body.each do |o| 
   if (o.text).match /weklfwefkl/
	puts "Found! \n Your post is: #{o.text}" 
	found = true 
	end
end
print "not found" if found == false

browser.close
