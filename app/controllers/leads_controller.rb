class LeadsController < ApplicationController
  protect_from_forgery with: :exception

  def create
    lead = Lead.new(lead_params)
    if lead.save
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, notice: "Thanks — we'll reach out shortly." }
        format.json { render json: { ok: true } }
      end
    else
      respond_to do |format|
        format.html { redirect_back fallback_location: root_path, alert: lead.errors.full_messages.join(", ") }
        format.json { render json: { ok: false, errors: lead.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  private
  def lead_params
    params.require(:lead).permit(:name, :email, :company, :role, :use_case, :city, :industry, :interest_datasets, :interest_api, :consent)
  end
end

