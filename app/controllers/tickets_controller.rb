class TicketsController < ApplicationController
  before_action :set_ticket, only: %i[ show edit update destroy ]
  after_action :send_email_to_user, only: %i[ create ] , if: :send_due_date_reminder?

  # GET /tickets or /tickets.json
  def index
    @tickets = Ticket.all
  end

  # GET /tickets/1 or /tickets/1.json
  def show
  end

  # GET /tickets/new
  def new
    @ticket = Ticket.new
  end

  # GET /tickets/1/edit
  def edit
  end

  # POST /tickets or /tickets.json
  def create
    @ticket = Ticket.new(ticket_params)

    respond_to do |format|
      if @ticket.save
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully created." }
        format.json { render :show, status: :created, location: @ticket }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tickets/1 or /tickets/1.json
  def update
    respond_to do |format|
      if @ticket.update(ticket_params)
        format.html { redirect_to ticket_url(@ticket), notice: "Ticket was successfully updated." }
        format.json { render :show, status: :ok, location: @ticket }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @ticket.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tickets/1 or /tickets/1.json
  def destroy
    @ticket.destroy

    respond_to do |format|
      format.html { redirect_to tickets_url, notice: "Ticket was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ticket
      @ticket = Ticket.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ticket_params
      params.require(:ticket).permit(:title, :description, :user_id, :due_date, :status_id, :progress)
    end

    def send_email_to_user 
      SendMailJob.set(wait_until: caluculate_due_date_reminder_time).perform_later(@ticket)
      # UserMailer.with(ticket: @ticket).due_date_reminder.deliver_now
    end
    
    def send_due_date_reminder?
      @ticket.user.send_due_date_reminder
    end

    def caluculate_due_date_reminder_time
      t = @ticket.due_date
      u = @ticket.user.due_date_reminder_time
      due_date = DateTime.new(t.year, t.month, t.day, u.hour, u.min, u.sec, DateTime.now.in_time_zone(@ticket.user.time_zone).zone)
      due_date_with_interval = due_date - (1.day * @ticket.user.due_date_reminder_interval)
    end
end
