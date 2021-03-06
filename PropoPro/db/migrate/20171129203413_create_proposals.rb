class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.integer :admin_id
      t.integer :user_id
      t.integer :reason_id
      t.string :milestone_1
      t.string :milestone_2
      t.string :milestone_3
      t.string :signer_name
      t.string :title
      t.string :email
      t.integer :budget
      t.string :fee_details
      t.string :terms
      t.boolean :invoice_paid, :default => false
      t.boolean :proposal_accepted, :default => false
      t.timestamps null: false
    end
  end
end
