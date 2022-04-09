# frozen_string_literal: true

class Comment < ApplicationRecord
  has_one :hn_parent, class_name: 'Comment', primary_key: 'parent_id', foreign_key: 'hn_id'
  has_many :kids, class_name: 'Comment', primary_key: 'hn_id', foreign_key: 'parent_id'

  def populate(json)
    return if json.blank?

    assign_attributes(
      {
        hn_id: json['id'],
        by: json['by'],
        parent_id: json['parent'],
        text: json['text'],
        dead: json['dead'],
        time: (DateTime.strptime((json['time']).to_s, '%s') if json['time'])
      }.compact
    )
  end
end
