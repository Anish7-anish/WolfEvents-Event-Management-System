class EventsController < ApplicationController
  before_action :set_event, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, except: [:index, :show]

  def index
    @events = Event.upcoming.not_sold_out
    filter_events
  end

  def show
  end

  def new
    @event = Event.new
    @rooms = Room.all
  end

  def edit
    @rooms = Room.all
  end

  def create
    @event = Event.new(event_params)

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :room_id, :category, :date, :start_time, :end_time, :ticket_price, :number_of_seats_left)
  end

  def require_admin
    redirect_to root_path, alert: "You don't have permission to access this page." unless current_user && current_user.is_admin
  end

  def filter_events
    @events = @events.where(category: params[:category]) if params[:category].present?
    @events = @events.where(date: params[:date]) if params[:date].present?
    if params[:min_price].present? && params[:max_price].present?
      @events = @events.where(ticket_price: params[:min_price]..params[:max_price])
    end
    @events = @events.where("name LIKE ?", "%#{params[:search]}%") if params[:search].present?
  end

  def book
    @event = Event.find(params[:id])
    # Logic for booking the event...
  end
end
