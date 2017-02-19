class CreateVerifications < ActiveRecord::Migration[5.0]
  def change
    create_table :verifications, :force => true do |t|
      t.references :verifiable, polymorphic: true, index: true
      t.string :candidate_id
      t.string :order_id
      t.string :status
      t.string :result
      t.timestamps
    end
  end
end
