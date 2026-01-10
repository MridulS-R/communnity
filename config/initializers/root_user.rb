# Creates or updates a root/admin user from environment variables.
# Set ROOT_EMAIL and ROOT_PASSWORD (and optional ROOT_NAME) in the environment.

if ENV["ROOT_EMAIL"].present? && ENV["ROOT_PASSWORD"].present?
  begin
    email = ENV["ROOT_EMAIL"].to_s.downcase.strip
    name  = (ENV["ROOT_NAME"].presence || "Root User").to_s

    user = User.find_or_initialize_by(email: email)
    user.name = name if user.name.blank?
    user.admin = true
    if user.new_record? || ENV["ROOT_RESET_PASSWORD"].present?
      user.password = ENV["ROOT_PASSWORD"]
      user.password_confirmation = ENV["ROOT_PASSWORD"]
    end
    user.save!
    Rails.logger.info("[boot] Root admin ensured: #{email}")
  rescue => e
    Rails.logger.error("[boot] Failed to ensure root admin: #{e.class}: #{e.message}")
  end
end

