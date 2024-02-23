class AttendeesController < ApplicationController
  before_action :set_attendee, only: %i[ show edit update destroy ]
  before_action :require_same_user, only: [:edit, :update, :destroy, :show]

  # GET /attendees or /attendees.json
  def index
    @attendees = Attendee.all
  end

  # GET /attendees/1 or /attendees/1.json
  def show
  end

  # GET /attendees/new
  def new
    @attendee = Attendee.new
  end

  # GET /attendees/1/edit
  def edit
    # Prevent non-admin attendees from updating their ID
    unless current_user.is_admin
      redirect_to root_path, alert: "You are not authorized to perform this action." unless @attendee == current_user
    end
  end

  # POST /attendees or /attendees.json
  def create
    @attendee = Attendee.new(attendee_params)

    respond_to do |format|
      if @attendee.save
        format.html { redirect_to root_path, notice: "Attendee was successfully created." }
        format.json { render :show, status: :created, location: @attendee }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /attendees/1 or /attendees/1.json
  def update
    respond_to do |format|
      if @attendee.update(attendee_params)
        format.html { redirect_to attendee_url(@attendee), notice: "Attendee was successfully updated." }
        format.json { render :show, status: :ok, location: @attendee }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @attendee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendees/1 or /attendees/1.json
  def destroy
    EventTicket.where("attendee_id=?", @attendee.id ).limit(5000).delete_all
    Review.where("attendee_id=?", @attendee.id ).limit(5000).delete_all

    # Only clear session if the current user is the attendee being destroyed and is not an admin
    if current_user == @attendee && !current_user.is_admin
      session[:user_id] = nil
    end

    @attendee.destroy

    respond_to do |format|
      format.html {
        if current_user && current_user.is_admin
          redirect_to attendees_url, notice: "Attendee was successfully destroyed."
        else
          redirect_to root_path, notice: "Account deleted successfully."
        end
      }
      format.json { head :no_content }
    end
  end

  def search
    event_name = params[:event_name]
    @attendees = Attendee.joins(:event_tickets).joins(:events).where("events.name = ?", event_name).distinct
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_attendee
    @attendee = Attendee.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def attendee_params
    params.require(:attendee).permit(:email, :password, :name, :phone_number, :address, :credit_card_info, :is_admin)
  end

  def require_same_user
    unless current_user == @attendee or current_user.is_admin?
      render file: "#{Rails.root}/public/403.html", status: :forbidden, layout: false
    end
  end
end