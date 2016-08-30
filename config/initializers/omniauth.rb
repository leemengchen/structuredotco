OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '294223037622540', '3f71e56345432518ae3efcb2ee9b771e'
end
