class AddProfilesToProfile < ActiveRecord::Migration[5.1]
  def change
    add_column :profiles, :sex, :integer
    add_column :profiles, :birthday, :date
    add_index :profiles, :birthday
    add_column :profiles, :job, :string
    add_index :profiles, :job
    add_column :profiles, :hobby, :string
    add_column :profiles, :job, :string
  end
end
