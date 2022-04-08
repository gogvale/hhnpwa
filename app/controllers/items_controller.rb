# frozen_string_literal: true

class ItemsController < ApplicationController
  def show
    @item = Item.find_by_hn_id params[:id]
  end
end
