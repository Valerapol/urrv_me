class AddFieldToEvents < ActiveRecord::Migration[6.1]
  def change
    add_column :events, :title_en, :string
    add_column :events, :body_en, :text
  end
end
