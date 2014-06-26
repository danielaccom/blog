class AddApprovedToComment < ActiveRecord::Migration
  def change
  	add_column :comments , :approved, :boolean , :default => false
  end

  def down

  end
end
