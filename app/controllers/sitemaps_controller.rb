class SitemapsController < ApplicationController
  def index
    @datasets = JSON.parse(File.read(Rails.root.join("app/data/datasets.json")))
  end
end

