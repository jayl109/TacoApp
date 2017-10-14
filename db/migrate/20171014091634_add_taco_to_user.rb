class AddTacoToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :tacos, :user, foreign_key: true
  end
end
