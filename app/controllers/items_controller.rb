class ItemsController < ApplicationController

  def index
    @items = Item.all

    if params[:query].present?
      @items = Item.search(
      params[:query],
      fields: [:title , :description],
      match: :word_start,
      operator: "or")
    else
      @items = Item.all
    end
  end
end
