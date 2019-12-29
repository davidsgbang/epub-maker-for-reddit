require 'redd'
require 'yaml'
require 'pp'

CONFIG = YAML.load_file("./config/config.yaml") unless defined? CONFIG

puts "Self-Post only!"
print "Link ID: "
id = gets.strip

session = Redd.it(
    user_agent: 'script:epub-maker-for-reddit:v.0.1 (by /u/KleenexDevourer)',
    client_id:  CONFIG['client_id'],
    secret:     CONFIG['secret'],
    username:   CONFIG['username'],
    password:   CONFIG['password']
  )

submission = session.from_ids("t3_#{id}").first

puts submission.selftext_html