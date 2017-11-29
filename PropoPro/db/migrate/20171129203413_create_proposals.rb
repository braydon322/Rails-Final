class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.integer :admin_id
      t.integer :user_id
      t.string :title
      t.integer :budget
      t.boolean :invoice_paid, :default => false
      t.boolean :proposal_accepted, :default => false
      t.timestamps null: false
    end
  end
end
