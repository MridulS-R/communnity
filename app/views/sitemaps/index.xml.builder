xml.instruct! :xml, version: "1.0", encoding: "UTF-8"
xml.urlset xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9" do
  [root_url, products_url, catalog_url, solutions_url, api_url, quality_url, pricing_url, about_url, contact_url].each do |u|
    xml.url { xml.loc u; xml.changefreq "weekly"; xml.priority "0.8" }
  end
  @datasets.each do |d|
    xml.url do
      xml.loc dataset_url(d["slug"]) 
      xml.changefreq "weekly"
      xml.priority "0.6"
    end
  end
end

