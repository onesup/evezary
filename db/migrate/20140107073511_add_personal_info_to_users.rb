class AddPersonalInfoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :string
    add_column :users, :blog_code, :string
    add_column :users, :survey_id, :integer
  end
end
