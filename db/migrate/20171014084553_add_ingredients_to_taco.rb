class AddIngredientsToTaco < ActiveRecord::Migration[5.0]
  def change
    add_column :tacos, :mixin, :string, array: true, default: []
    add_column :tacos, :condiment, :string, array: true, default: []
    add_column :tacos, :seasoning, :string, array: true, default: []


  end
end
