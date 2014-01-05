# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# Node::Application.config.secret_token = '3cbf884938c4dc62fc00a20fcb1ad1cf866fa9d41ce2140b4944c12cdb2d40ecb33f309742e350a8f6496b4e1ab0f35a8755101e491e92f29dd2cb686af41cb5'

def secure_token
  token_file = Rails.root.join('.secret')
  if File.exist?(token_file)
    # Use the existing token.
    File.read(token_file).chomp
  else
    # Generate a new token and store it in token_file.
    token = SecureRandom.hex(64)
    File.write(token_file, token)
    token
  end
end

Node::Application.config.secret_token = secure_token