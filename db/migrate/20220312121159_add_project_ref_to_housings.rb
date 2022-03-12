class AddProjectRefToHousings < ActiveRecord::Migration[7.0]
  def change
    add_reference :housings, :project, null: false, foreign_key: true
  end
end
