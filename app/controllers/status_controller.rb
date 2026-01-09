class StatusController < ApplicationController
  def show
    render json: { ok: true, time: Time.current, rev: ENV["RENDER_GIT_COMMIT"] }, status: :ok
  end

  def health
    render plain: "ok", status: :ok
  end
end

