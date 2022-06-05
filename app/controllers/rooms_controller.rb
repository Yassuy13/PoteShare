class RoomsController < ApplicationController
  def index
    @rooms = Room.where('title LIKE ? or address LIKE ?', "%#{params[:search]}%", "%#{params[:search]}%")
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new
  end

  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    @room.user_id = current_user.id
    if @room.save
      flash[:notice] = "ルームを新規登録しました"
      redirect_to room_path(@room)
    else
      flash.now[:alert] = "ルームを登録できませんでした"
      redirect_to :new_room
    end
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      redirect_to room_path(@room), notice: "部屋を更新しました。"
    else
      redirect_to :edit_room
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_path
    flash[:notice] = 'ルームを削除しました'
  end


  private
  def room_params
    params.require(:room).permit(:title, :body, :price, :address, :room_image)
  end
end