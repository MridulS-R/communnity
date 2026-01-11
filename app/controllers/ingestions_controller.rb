require 'csv'

class IngestionsController < ApplicationController
  before_action :require_admin

  def index
    @batches = IngestionBatch.order(created_at: :desc).limit(50).includes(:source)
  end

  def new
    @source = Source.new
  end

  def create
    file = params.dig(:upload, :file)
    unless file
      return redirect_to new_ingestion_path, alert: "Please choose a CSV file"
    end

    source_name = params.dig(:upload, :source_name).presence || "CSV upload — #{current_user.email} — #{Time.current.to_s(:db)}"
    source = Source.create!(name: source_name, kind: :csv_upload, metadata: { uploaded_by: current_user.email })
    batch = IngestionBatch.create!(source: source, status: :running, started_at: Time.current)

    processed = 0
    duplicates = 0
    errors = 0

    CSV.foreach(file.path, headers: true) do |row|
      processed += 1
      payload = row.to_h.transform_keys { |k| k.to_s.strip }
      next if payload.values.all? { |v| v.to_s.strip.empty? }

      fingerprint = Digest::SHA256.hexdigest(payload.to_json)
      if RawRecord.exists?(fingerprint: fingerprint)
        duplicates += 1
        next
      end

      attrs = {
        source_id: source.id,
        ingestion_batch_id: batch.id,
        external_id: payload["external_id"] || payload["id"],
        name: payload["name"] || payload["company_name"] || payload["business_name"],
        address: payload["address"],
        city: payload["city"],
        state: payload["state"],
        pincode: payload["pincode"],
        phone: payload["phone"],
        email: payload["email"],
        category: payload["category"],
        fingerprint: fingerprint,
        payload: payload
      }
      begin
        RawRecord.create!(attrs)
      rescue => _e
        errors += 1
      end
    end

    batch.update!(
      status: :completed,
      finished_at: Time.current,
      total_count: processed,
      processed_count: processed - errors,
      duplicate_count: duplicates,
      metrics: { errors: errors }
    )

    redirect_to ingestion_path(batch), notice: "Ingestion completed: #{processed - errors} records, #{duplicates} duplicates, #{errors} errors"
  rescue => e
    batch.update(status: :failed, finished_at: Time.current, notes: e.message) if batch&.persisted?
    redirect_to new_ingestion_path, alert: "Failed to ingest: #{e.message}"
  end

  def show
    @batch = IngestionBatch.find(params[:id])
  end
end

