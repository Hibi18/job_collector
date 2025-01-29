class CreateJobs < ActiveRecord::Migration[8.0]
  def change
    create_table :jobs do |t|
      t.string :title
      t.string :location
      t.string :salary
      t.string :company

      t.timestamps
    end
  end
end
