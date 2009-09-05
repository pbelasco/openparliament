# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_openparliament_session',
  :secret      => '827b5da838cdcd59fa5520f684b6da03ec7b746fe4b9eab2365c6dfdcef9460b8a604a937ee8cac394b957f9042ca595ace18bf0041507b0b07f320e13097a8e'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
