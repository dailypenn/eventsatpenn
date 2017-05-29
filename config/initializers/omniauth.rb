fb_app_id = Rails.application.secrets.fb_app_id
fb_app_secret = Rails.application.secrets.fb_app_secret

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, fb_app_id, fb_app_secret,
  scope: 'public_profile, email, user_events, manage_pages', display: 'popup',
  image_size: {:width => 250, :height => 250},
  info_fields: 'name, email, first_name, last_name, education, accounts'
end

auth = FbGraph2::Auth.new(fb_app_id, fb_app_secret)
auth.access_token!
