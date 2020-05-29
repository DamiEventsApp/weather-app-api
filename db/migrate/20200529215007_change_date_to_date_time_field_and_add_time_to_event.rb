class ChangeDateToDateTimeFieldAndAddTimeToEvent < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :time, :string
    change_column :events, :date, :string
  end
end
