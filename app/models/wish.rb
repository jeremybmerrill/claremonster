class Wish < ActiveRecord::Base

require 'twilio-ruby'


validates_uniqueness_of :description, :scope => :title
validates_presence_of :title, :description, :threshold

belongs_to :user
has_many :upvotes
has_many :comments, :dependent => :destroy

  def textUsers
    account_sid = ENV['TWILIO_SID']
    auth_token = ENV['TWILIO_TOKEN']
    #in heroku at ENV['TWILIO_SID'] and ENV['TWILIO_TOKEN'],
    #set via heroku config:add TWILIO_TOKEN=1234567etc

    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new account_sid, auth_token

    self.upvotes.find_all{ |upv| upv.user and not upv.user.phonenumber.nil? }.each do |upvote|
      text_this_user = upvote.user

      clean_phone = text_this_user.phonenumber.gsub(" ", "").gsub("(", "").gsub(")", "").gsub("-", "").gsub(".", "") 
      
      text_string = 'Your deal for ' + self.title + " has been claimed by " + self.claimmsg[self.claimmsg.index(" claimed")] + "! Go there for your incentive!"
      text_string = text_string[0..159]
      
      @client.account.sms.messages.create(
        :from => '+14155992671',
        :to => "+1" + clean_phone,
        :body => text_string
      )
    end
  end
end
