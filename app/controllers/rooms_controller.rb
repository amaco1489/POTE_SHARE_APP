class RoomsController < ApplicationController

  def index
    @rooms = Room.all
  end

  def new
    @room = Room.new
  end

  def create
    @room = current_user.rooms.new(room_params)
    if @room.save
      flash[:notice] = "Roomを登録しました"
      redirect_to user_room_rooms_path
    else
      render "new"
    end
  end

  def show
    @room = Room.find(params[:id])
    @user = @room.user
    @reservation = Reservation.new
  end

  def post_room
    @room = current_user.rooms
  end


  def search_tokyo
    @rooms = Room.where("address like?", "%東京%")
    render "index"
  end

  def search_osaka
    @rooms = Room.where("address like?", "%大阪%")
    render "index"
  end

  def search_kyoto
    @rooms = Room.where("address like?", "%京都府%")
    render "index"
  end

  def search_sapporo
    @rooms = Room.where("address like?", "%札幌%")
    render "index"
  end

  def search
    @rooms = Room.where('address like ? OR room_name like ? OR room_introduction like ? OR price like ?', "%#{params[:keyword]}%",  "%#{params[:keyword]}%",  "%#{params[:keyword]}%",  "%#{params[:keyword]}%")
    render "index"
  end

  def area_search
    @rooms = Room.where('address like ?', "%#{params[:keyword]}%")
    render "index"
  end
  
  private

  def room_params
    params.require(:room).permit(:room_name, :address, :room_introduction, :price, :room_img)
  end

end
