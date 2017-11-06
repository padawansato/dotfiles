class AddProfilesToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :sex_id, :integer
    add_column :profiles, :birthday_id, :date
    add_index :profiles, :birthday_id
    add_column :profiles, :job_id, :string
    add_index :profiles, :job_id
    add_column :profiles, :hobby_id, :string
    add_index :profiles, :hobby_id
  end
end
