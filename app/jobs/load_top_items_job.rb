# frozen_string_literal: true

class LoadTopItemsJob < ApplicationJob
  queue_as :default

  def perform
    top_stories_json = JSON.parse HTTP.get('https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty').to_s

    top_stories_json.each_with_index do |hn_story_id, top_news_location|
      story_json = JSON.parse HTTP.get("https://hacker-news.firebaseio.com/v0/item/#{hn_story_id}.json?print=pretty").to_s
      return if story_json.blank?

      item = Item.where(hn_id: hn_story_id).first_or_create
      item.populate(story_json)
      item.save

      top_item = TopItem.where(location: top_news_location).first_or_create
      top_item.item = item
      top_item.save
    rescue URI::InvalidURIError => e
      logger.error e
    end
  end
end
