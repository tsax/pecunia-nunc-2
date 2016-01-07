class AddActiveToSubscriber < ActiveRecord::Migration
  def change
    add_column :subscribers, :active, :boolean
  end
end
