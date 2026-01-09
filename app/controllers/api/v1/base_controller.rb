module Api
  module V1
    class BaseController < ActionController::API
      before_action :authenticate!

      private
      def authenticate!
        header = request.headers["Authorization"]
        unless header&.start_with?("Bearer ")
          return render json: { error: "missing_token" }, status: :unauthorized
        end
        token = header.split(" ", 2).last
        @api_key = ApiKey.active.find_by(token: token)
        return render(json: { error: "invalid_token" }, status: :unauthorized) unless @api_key
        @api_key.update_columns(last_used_at: Time.current) if @api_key.persisted?
      end
    end
  end
end

