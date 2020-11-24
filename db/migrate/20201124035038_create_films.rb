class CreateFilms < ActiveRecord::Migration[6.0]
  def change
    create_table :films do |t|
      t.string :title
      t.string :imdb_number
      t.string :string
      t.integer :thumbs_up
      t.integer :thumbs_down
      t.timestamps
    end
  end
end
