class ChangeDateToBigIntOnEvents < ActiveRecord::Migration[6.0]
  def change
    change_column :events, :date, :bigint, nil:false
  end
end
