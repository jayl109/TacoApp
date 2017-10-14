class CreateTacos < ActiveRecord::Migration[5.0]
  def change
    create_table :tacos do |t|
      t.string :shells
      t.string :baselayers
      #t.belongs_to :user, default: nil, index: true

      t.timestamps
    end
  end
end
