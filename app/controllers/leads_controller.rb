class LeadsController < ApplicationController
  protect_from_forgery with: :exception

  def create
    lead = Lead.new(lead_params)
    if lead.save
      LeadWebhookJob.perform_later(lead.id)
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, notice: "Thanks — we'll reach out shortly." }
        format.json { render json: { ok: true } }
      end
    else
      errors = lead.errors.full_messages
      respond_to do |format|
        format.html {
          flash[:lead_errors] = errors
          redirect_back fallback_location: root_path
        }
        format.json { render json: { ok: false, errors: errors }, status: :unprocessable_entity }
      end
    end
  end

  private
  def lead_params
    params.require(:lead).permit(:name, :email, :company, :role, :use_case, :city, :industry, :interest_datasets, :interest_api, :consent)
  end
end
