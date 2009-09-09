# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_openparliament_session',
  :secret      => '0a81321b64488c651f6c6be43b8ceb59c107688730e1bb651d01d8a4beafcc18e2924e748c8a65e5310811eb3a7c6c7da817ebc548d9d1bc1988939eba28cd89'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
