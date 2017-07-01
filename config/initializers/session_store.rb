Rails.application.config.session_store :active_record_store, :key => Rails.application.secrets.secret_key_base
