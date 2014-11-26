class CreateMuseums < ActiveRecord::Migration
  def change
    create_table :museums do |t|

      t.timestamps
    end
  end
end
