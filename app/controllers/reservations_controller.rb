class ReservationsController < ApplicationController
  def index
    @reservations = Reservation.where(user_id: current_user.id)
  end

  def show
    @reservation = Reservation.find(params[:id])
    @room = Room.find(params[:room_id])
    @price = (@reservation.check_out.to_date - @reservation.check_in.to_date).to_i * @room.price * @reservation.person
  end

  def new
    @room = Room.find(params[:room_id])
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to room_reservation_path(@reservation.room_id, @reservation)
    else
      redirect_to room_path(@reservation.room_id)
    end
  end

  def edit
    
  end

  private
  def reservation_params
    params.require(:reservation).permit(:check_in, :check_out, :person, :room_id, :user_id)
  end
end