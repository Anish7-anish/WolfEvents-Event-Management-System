class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy]
  before_action :require_admin, only: [:edit, :update, :destroy, :show]

  # GET /rooms or /rooms.json
  def index
    @available_rooms = Room.all

    if params[:date].present? && params[:start_time].present? && params[:end_time].present?
      desired_date = Date.parse(params[:date])
      start_time = Time.zone.parse("#{params[:date]} #{params[:start_time]}")
      end_time = Time.zone.parse("#{params[:date]} #{params[:end_time]}")

      # Find rooms with events that don't match the desired date
      rooms_with_conflicts = Room.joins(:events)
                                 .where(events: { date: desired_date })
                                 .where.not("events.start_time >= ? AND events.end_time <= ?", end_time, start_time)
                                 .distinct.pluck(:id)

      # Find rooms without events
      rooms_without_events = Room.left_outer_joins(:events)
                                 .where(events: { date: desired_date })
                                 .where(events: { id: nil })
                                 .pluck(:id)

      # Combine the two sets of room IDs
      available_room_ids = (rooms_without_events + rooms_with_conflicts).uniq

      # Retrieve the available rooms
      @available_rooms = Room.where.not(id: available_room_ids)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @available_rooms }
    end
  end

  # GET /rooms/1 or /rooms/1.json
  def show
  end

  # GET /rooms/new
  def new
    @room = Room.new
  end

  # GET /rooms/1/edit
  def edit
  end

  # POST /rooms or /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Room was successfully created.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1 or /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Room was successfully updated.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1 or /rooms/1.json
  def destroy
    begin
      ActiveRecord::Base.transaction do
        @room.events.destroy_all
        @room.destroy
      end

      respond_to do |format|
        format.html { redirect_to rooms_url, notice: 'Room and associated events were successfully destroyed.' }
        format.json { head :no_content }
      end
    rescue ActiveRecord::InvalidForeignKey
      respond_to do |format|
        format.html { redirect_to rooms_url, alert: 'Failed to destroy room. Make sure there are no associated records.' }
        format.json { render json: { error: 'Failed to destroy room. Make sure there are no associated records.' }, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def room_params
    params.require(:room).permit(:location, :capacity)
  end

  # Ensure only admin users can access certain actions
  def require_admin
    unless current_user && current_user.is_admin
      redirect_to root_path, alert: "You are not authorized to perform this action."
    end
  end
end
