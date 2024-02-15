class ReviewsController < ApplicationController
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :check_event_category, only: [:new], unless: :admin?

  # GET /reviews or /reviews.json
  def index
    @reviews = Review.all

    if params[:attendee_name].present?
      @reviews = @reviews.joins(:attendee).where("attendees.name LIKE ?", "%#{params[:attendee_name]}%")
    end

    if params[:event_id].present?
      @reviews = @reviews.joins(:event).where(events: { id: params[:event_id] })
    end

    if params[:attendee_email].present?
      @reviews = @reviews.joins(:attendee).where("attendees.email LIKE ?", "%#{params[:attendee_email]}%")
    end

    if params[:event_name].present?
      @reviews = @reviews.joins(:event).where("events.name LIKE ?", "%#{params[:event_name]}%")
    end
  end

  # GET /reviews/1 or /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
    @review.attendee_id = current_user.id # Adjust as per your user session management
    @review.event_id = params[:event_id]
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    @review = Review.new(review_params)
    # event = Event.find(@review.event_id)
    if admin?
      event = Event.find(@review.event_id)
      if event.category.in?(['Miscellaneous', 'Private'])
        redirect_to (request.referer || root_path), alert: "Reviews are not allowed for events in Miscellaneous/Private categories." and return
      end
      if event.date >= Date.current
        redirect_to events_path, alert: "Reviews can only be written for events that have already occurred."
        return
      end
    end
    respond_to do |format|
      if @review.save
        format.html { redirect_to review_url(@review), notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to review_url(@review), notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy!

    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_review
    @review = Review.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def review_params
    params.require(:review).permit(:attendee_id, :event_id, :rating, :feedback)
  end

  def admin?
    current_user&.is_admin?
  end


  def check_event_category
    event = Event.find(params[:event_id])
    if event.category.in?(['Miscellaneous', 'Private'])
      redirect_to root_path, alert: "Reviews are not allowed for events in Miscellaneous/Private categories."
    end
    if event.date >= Date.current
      redirect_to events_path, alert: "Reviews can only be written for events that have already occurred."
      return
    end
  end
end