
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
    browser.button(class: "create_post_button").click
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
   def delete_blog(browser)
    browser.goto "https://www.tumblr.com/blog/afridiharis"
    browser.div(class: "post_control").click
    browser.div(class: "post_control delete").click
    browser.button(class: "ui_button").click
  end
end