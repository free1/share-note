Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, 'b5dbafa2f8ad0a045e78',
    'c2a3ad3aa68578387b939902042f697240b527eb'
end

