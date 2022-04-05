class CreateDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :documents do |t|
      t.text :title
      t.string :tipe

      t.timestamps
    end
  end
end
