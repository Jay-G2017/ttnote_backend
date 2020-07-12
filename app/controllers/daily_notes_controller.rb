class DailyNotesController < ApplicationController
  def index
    if params['date'].present?
      arr = params['date'].split('-').map(&:to_i)
      date = Date.new(*arr)
    else
      date = Date.today
    end

    note = DailyNote.where(user_id: current_user.id).where({ created_at: date.beginning_of_day..date.end_of_day }).first
    if note.present?
    else
      note = create
    end
    render json: note
  end

  def update
    note = DailyNote.find_by(id: params[:id])
    authorize note, :update?
    note.update!(note_params)

    render json: note
  end

  private

  def create
    note = DailyNote.new
    note.user = current_user
    note.save!
    note
  end

  def note_params
    params.require(:daily_note).permit(:desc)
  end
end
