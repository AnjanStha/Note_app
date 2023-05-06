class NoteController < ApplicationController
  
  def index
    @notes = current_user.notes.includes(:user)
  
    # user select date filter for notes
    if params[:start_date].present?
      start_date = Date.parse(params[:start_date])
      @notes = @notes.where("DATE(created_at) = ?", start_date)
    end
  end
  
  
  # for create new note
  def new
    @note = Note.new
  end
  
  # for save new note in database
  def create
    @note = Note.new(note_params)
    if @note.save
      redirect_to note_path
      
    else
      render :new
      # p "does not save data"
      puts @note.errors.full_messages
    end
  end
  


  def edit
    p params
    if params[:id].present?
      @note = Note.find(params[:id])
      p @note
    else
      redirect_to note_path, alert: "Note not found"
      
    end
  end
  
  

  def update

    @note = Note.find(params[:note][:id])
    if @note.update(note_params)
      redirect_to note_path(@note)
    else
      render :edit
    end
  end
  

  def destroy
    @note = Note.find(params[:id])
    @note.destroy
    redirect_to note_path
  end
  
  private
  
  def note_params
    params.require(:note).permit(:title, :content).merge(user_id: current_user.id)
  end
  
end
