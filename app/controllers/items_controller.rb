class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit destroy]
  before_action :admin?, except: %i[index show]

  def index
    if params[:query].present?
      @items = Item.search(params[:query], match: :word_start)
    else
      @items = Item.all
    end
  end

  def show; end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:title, :description, :price, :picture)
  end
end
