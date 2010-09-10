# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_peer_session',
  :secret      => '9930a2f217a43a64b6d9849dcde0c1c5fe483a6278f7e4244913e33825841d4462bc2dbb8388b2c61ffcd5432a6c5e14a2623e21b4533482db07b1c568ceb2d0'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
