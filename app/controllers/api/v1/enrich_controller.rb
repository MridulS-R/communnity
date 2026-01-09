module Api
  module V1
    class EnrichController < BaseController
      def create
        name = params[:name].to_s
        city = params[:city].to_s
        # Mock enrichment: echo back with a deterministic entity_id and status
        entity_id = "ENT-" + Digest::SHA256.hexdigest([name, city].join("|"))[0,8]
        render json: {
          data: {
            entity_id: entity_id,
            name: name,
            city: city,
            status: "verified",
            last_verified_days: 30
          }
        }
      end
    end
  end
end

