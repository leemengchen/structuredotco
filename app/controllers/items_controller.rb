class ItemsController < ApplicationController

  def index
    @items = Item.all
    # @item = Item.second
  end
end
