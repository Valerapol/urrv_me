class AddAplicationToDocument < ActiveRecord::Migration[6.1]
  def change
    add_column :documents, :aplication, :string
  end
end
