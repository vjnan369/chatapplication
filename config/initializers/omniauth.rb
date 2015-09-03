OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '677267510351-c3ksj0ig4jsf3jrh8vu26v3nsjmu8l63.apps.googleusercontent.com', 'ueEFOPrThwJf-v64iHhxcDnY', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end