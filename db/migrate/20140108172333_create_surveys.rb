class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :code
      t.string :title
      t.integer :total

      t.timestamps
    end
  end
end
