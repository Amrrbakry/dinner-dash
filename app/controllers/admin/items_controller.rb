class Admin::ItemsController < ApplicationController
	before_action :set_item, 					only: [:show, :edit, :destroy, :update] 
	before_action :admin?

	def show
	end

	def index
		@items = Item.all
	end
	
	def create
		@category = Category.find(params[:category_id])
		@item = Item.new(item_params)
		if @item.save && @category.items_categories.create(item_id: @item.id)
			flash[:notice] = "Item created successfully"
			redirect_to root_url
		else
			render :new
			flash.now[:alert] = "Error creating item"
		end
	end

	def new
		@item = Item.new
	end

	def edit
	end

	def update
		if @item.update(item_params)
			flash[:notice] = "Item updated!"
			redirect_to @item
		else
			render :edit
			flash.now[:alert] = "Error updating item"
		end
	end

	def destroy
		@item.destroy
		flash[:notice] = "Item deleted!"
		redirect_back(fallback_location: root_url)
	end

	private

		def set_item
			@item = Item.find(params[:id])
		end

		def item_params
			params.require(:item).permit(:title, :description, :price, :picture, :category_id)
		end
end