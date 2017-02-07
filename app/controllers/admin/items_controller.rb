class Admin::ItemsController < ApplicationController
	before_action :set_item, 					only: [:show, :edit, :destroy, :update] 
	before_action :admin?
	before_save :add_default_picture
	
	def show
	end

	def index
		@items = Item.all
	end
	
	def create
		@item = Item.new(item_params)
		if @item.save
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
			params.require(:item).permit(:title, :description, :price, :picture)
		end

		# add default picture for item if not picture is provided
		def add_default_picture
			if @item.picture == nil
				@item.picture = "default_item_pic.jpg"
			end
		end
end