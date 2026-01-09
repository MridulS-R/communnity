module Api
  module V1
    class ResolveController < BaseController
      def create
        candidates = params[:candidates].to_a
        # Mock resolution: choose the first candidate and assign confidence
        chosen = candidates.first || {}
        render json: {
          data: {
            resolved: chosen,
            confidence: candidates.size > 1 ? 0.7 : 0.9
          }
        }
      end
    end
  end
end

