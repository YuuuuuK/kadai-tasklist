class CreateTasklists < ActiveRecord::Migration[5.0]
  def change
    create_table :tasklists do |t|
      t.string :Content

      t.timestamps
    end
  end
end
