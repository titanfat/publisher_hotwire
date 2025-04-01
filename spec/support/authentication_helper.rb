module AuthenticationHelper
  def login_as(user)
    session = create(:session, user: user)
    verifier = ActiveSupport::MessageVerifier.new(Rails.application.secret_key_base)
    signed_value = verifier.generate(session.id)

    if defined?(request)
      request.cookies['session_id'] = signed_value
    else
      cookies[:session_id] = signed_value
    end

    user
  end
end