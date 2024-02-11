class EventTicketsController < ApplicationController
  before_action :set_event_ticket, only: %i[ show edit update destroy ]

  # GET /event_tickets or /event_tickets.json
  def index
    @event_tickets = EventTicket.all
    attendee_param = params[:attendee_id]
    puts "hello"
    puts attendee_param
    if attendee_param
      @event_tickets =  EventTicket.find_by_attendee_id(attendee_param)
    end

  end

  # GET /event_tickets/1 or /event_tickets/1.json
  def show
  end

  # GET /event_tickets/new
  def new
    @event_ticket = EventTicket.new
  end

  # GET /event_tickets/1/edit
  def edit
  end

  # POST /event_tickets or /event_tickets.json
  def create
    @event_ticket = EventTicket.new(event_ticket_params)

    respond_to do |format|
      if @event_ticket.save
        format.html { redirect_to event_ticket_url(@event_ticket), notice: "Event ticket was successfully created." }
        format.json { render :show, status: :created, location: @event_ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /event_tickets/1 or /event_tickets/1.json
  def update
    respond_to do |format|
      if @event_ticket.update(event_ticket_params)
        format.html { redirect_to event_ticket_url(@event_ticket), notice: "Event ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @event_ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /event_tickets/1 or /event_tickets/1.json
  def destroy
    @event_ticket.destroy!

    respond_to do |format|
      format.html { redirect_to event_tickets_url, notice: "Event ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_ticket
      @event_ticket = EventTicket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_ticket_params
      params.require(:event_ticket).permit(:attendee_id, :event_id, :confirmation_number)
    end
end
