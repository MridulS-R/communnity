class CatalogController < ApplicationController
  before_action :load_datasets

  def index
    @q = params[:q].to_s.strip.downcase
    @datasets = @all_datasets

    if @q.present?
      @datasets = @datasets.select do |d|
        [d["name"], d["description"], d["industries"].join(" "), d.dig("geography", "state"), d.dig("geography", "city")]
          .compact
          .map { |s| s.to_s.downcase }
          .any? { |s| s.include?(@q) }
      end
    end

    # Basic filters
    if params[:state].present?
      @datasets = @datasets.select { |d| d.dig("geography", "state") == params[:state] }
    end
    if params[:city].present?
      @datasets = @datasets.select { |d| d.dig("geography", "city") == params[:city] }
    end
    if params[:industry].present?
      @datasets = @datasets.select { |d| d["industries"].include?(params[:industry]) }
    end
    if params[:freshness].present?
      case params[:freshness]
      when "lt30"
        @datasets = @datasets.select { |d| d["freshnessDaysMedian"].to_i < 30 }
      when "lt90"
        @datasets = @datasets.select { |d| d["freshnessDaysMedian"].to_i < 90 }
      end
    end
  end

  def show
    @dataset = @all_datasets.find { |d| d["slug"] == params[:slug] }
    render file: Rails.root.join("public/404.html"), status: :not_found, layout: false unless @dataset
  end

  private
  def load_datasets
    path = Rails.root.join("app", "data", "datasets.json")
    @all_datasets = JSON.parse(File.read(path))
  end
end

