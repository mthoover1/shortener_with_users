class AddUserIdColumnToUrls < ActiveRecord::Migration
  def change
    add_column :urls, :user_id, :integer
  end
end