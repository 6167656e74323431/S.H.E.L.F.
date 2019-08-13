class CreateBooks < ActiveRecord::Migration[5.2]
  def change
    create_table :books do |t|
      t.text :title
      t.text :author
      t.text :publisher
      t.integer :year
      t.text :isbn
      t.text :scannable
      t.string :shelf

      t.timestamps
    end
  end
end
