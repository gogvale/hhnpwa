# frozen_string_literal: true

class Item < ApplicationRecord
  has_one :top_item
  enum hn_type: %i[story job]

  def populate(json)
    return if json.blank?

    assign_attributes(
      {
        hn_id: json['id'],
        hn_type: json['type'],
        by: json['by'],
        text: json['text'],
        parent: json['parent'],
        url: json['url'],
        score: json['score'],
        descendants: json['descendants'],
        title: json['title'],
        host: (URI.parse(json['url']).host.gsub('www.', '') if json['url']),
        time: (DateTime.strptime((json['time']).to_s, '%s') if json['time'])
      }.compact_blank
    )
  end
end
