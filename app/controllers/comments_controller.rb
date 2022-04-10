# frozen_string_literal: true

class CommentsController < ApplicationController
  def index
    @item = Item.find_by_hn_id params[:item_id]

    http = PersistentHTTP.new(url: "https://hacker-news.firebaseio.com/v0/item/#{@item.hn_id}.json")
    item_json = JSON.parse http.request.body

    return if item_json.blank?

    @item.populate(item_json)
    @item.save
    load_kids(@item.hn_id, item_json)
  end

  def show
    @item = Item.find_by_hn_id params[:item_id]
    @comment = Comment.find_by_hn_id params[:id]
    http = PersistentHTTP.new(url: "https://hacker-news.firebaseio.com/v0/item/#{@comment.hn_id}.json")
    item_json = JSON.parse http.request.body
    return if item_json.blank?

    @comment.populate(item_json)
    @comment.save
    load_kids(@comment.hn_id, item_json)
  end

  private

  def load_kids(parent_id, item_json)
    if item_json&.key?('kids')
      item_json['kids'].each_with_index do |kid_hn_id, kid_location|
        http = PersistentHTTP.new(url: "https://hacker-news.firebaseio.com/v0/item/#{kid_hn_id}.json")
        kid_json = JSON.parse http.request.body
        next if kid_json.blank?

        kid = Comment.where(hn_id: kid_hn_id).first_or_create
        kid.location = kid_location
        kid.parent_id = parent_id
        kid.populate(kid_json)
        kid.save
      end
    end
  end
end
