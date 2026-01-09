module Api
  module V1
    class SearchController < BaseController
      def index
        q = params[:q].to_s.downcase
        datasets = JSON.parse(File.read(Rails.root.join("app/data/datasets.json")))
        results = if q.present?
          datasets.select { |d| d["name"].to_s.downcase.include?(q) || d["description"].to_s.downcase.include?(q) }
        else
          datasets.first(10)
        end
        render json: { data: results.map { |d| d.slice("slug","name","description","industries","geography","recordCount") } }
      end
    end
  end
end

