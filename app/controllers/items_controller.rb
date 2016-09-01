class ItemsController < ApplicationController

  def index
    # @items = Item.all

    if params[:query].present?
      @items = Item.search(params[:query])
    else
      @items = Item.all
    end
  end
end
