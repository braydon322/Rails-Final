class CreateReasons < ActiveRecord::Migration
  def change
    create_table :reasons do |t|
      t.integer :proposal_id
      t.string :content
      t.timestamps null: false
    end
  end
end
