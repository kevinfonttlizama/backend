module Api
  class ItemsController < ApplicationController
    def index
      @items = Item.all
      render json: @items
    end
  end
end
