class ReservationsController < ApplicationController

  before_action :authenticate_user!, except: [:index]

  def index
    @reservations = current_user.reservations.all
  end

  def new
    @reservation = Reservation.new
  end

  def confirm
    @reservation = current_user.reservations.new(reservation_params)
    @room = @reservation.room
    redirect_to room_path(@room), flash: {error: @reservation.errors.full_messages} if @reservation.invalid?
  end

  def create
    @reservation = current_user.reservations.new(reservation_params)
    @room = @reservation.room
    if @reservation.save
      flash[:notice] = "予約が完了しました"
      redirect_to reservation_path(@reservation)
    else
      render room_path(@room)
    end
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  private

  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :total_gests, :total_price, :room_id, :id)
  end

end
