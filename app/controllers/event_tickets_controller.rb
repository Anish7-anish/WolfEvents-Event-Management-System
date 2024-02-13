class EventTicketsController < ApplicationController
  before_action :set_event_ticket, only: %i[ show edit update destroy ]

  def index
    @event_tickets = EventTicket.all
    attendee_param = params[:attendee_id]
    if attendee_param
      @event_tickets = EventTicket.where(attendee_id: attendee_param)
    end
  end

  def show
  end

  def new
    @event_ticket = EventTicket.new
  end

  def edit
  end

  def create
    @event_ticket = EventTicket.new(event_ticket_params)

    respond_to do |format|
      if @event_ticket.save
        @event_ticket.event.decrease_seats_left
        format.html { redirect_to event_ticket_url(@event_ticket), notice: "Event ticket was successfully created." }
        format.json { render :show, status: :created, location: @event_ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event_ticket.errors, status: :unprocessable_entity }
      end
    end
  end

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

  def destroy
    @event_ticket.destroy!

    respond_to do |format|
      @event_ticket.event.increase_seats_left
      if current_user && current_user.respond_to?(:admin?) && current_user.admin?
        format.html { redirect_to event_tickets_url, notice: "Event ticket was successfully destroyed." }
      else
        format.html { redirect_to event_tickets_url, notice: "Event ticket was successfully cancelled." }
      end
      format.json { head :no_content }
    end
  end



  private
  def set_event_ticket
    @event_ticket = EventTicket.find(params[:id])
  end

  def event_ticket_params
    params.require(:event_ticket).permit(:attendee_id, :event_id, :confirmation_number)
  end
end
