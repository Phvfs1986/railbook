# frozen_string_literal: true

class CreatePictures < ActiveRecord::Migration[7.0]
  def change
    create_table :pictures do |t|
      t.bigint 'user_id', null: false
      t.timestamps
    end
  end
end
