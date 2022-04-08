# frozen_string_literal: true

ITEMS_PER_PAGE ||= 30
FIRST_PAGE ||= 0

class TopsController < ApplicationController
  def show
    @page = params[:page]&.to_i || FIRST_PAGE
    @total_pages = TopItem.count / ITEMS_PER_PAGE
    @stories = TopItem.order(:location)
                      .limit(ITEMS_PER_PAGE)
                      .offset(@page * ITEMS_PER_PAGE)
    @top_item = TopItem.order(:updated_at).last
  end

  def create
    LoadTopItemsJob.perform_now
  end
end
