class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.bigint :hn_id
      t.string :by
      t.integer :hn_type
      t.datetime :time
      t.text :text
      t.string :url
      t.string :host
      t.integer :score
      t.string :title
      t.integer :descendants

      t.timestamps
    end
    add_index :items, :hn_id
  end
end
