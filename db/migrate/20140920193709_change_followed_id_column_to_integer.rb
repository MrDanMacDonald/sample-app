class ChangeFollowedIdColumnToInteger < ActiveRecord::Migration
  def change
    remove_column :relationships, :followed_id
    add_column :relationships, :followed_id, :integer
  end
end
