if Rails.env == "production"
    Rails.application.config.session_store :cookie_store, 
    key: "_tax_turbo_app", domain: "http://localhost:3000",
    same_site: :none, secure: true
else
    Rails.application.config.session_store :cookie_store, 
    key: "_tax_turbo_app"
end
    