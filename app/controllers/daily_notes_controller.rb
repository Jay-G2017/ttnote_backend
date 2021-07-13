class DailyNotesController < ApplicationController
  def index
    if params['date'].present?
      arr = params['date'].split('-').map(&:to_i)
      date = Date.new(*arr)
    else
      date = Date.current
    end

    note = DailyNote.where(user_id: current_user.id).where({ date_at: date }).first
    if note.present?
    else
      note = create(date)
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

  def create(date)
    note = DailyNote.new
    note.user = current_user
    note.date_at = date
    note.save!
    note
  end

  def note_params
    params.require(:daily_note).permit(:desc)
  end
end
