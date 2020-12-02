class RemoveStringFromFilms < ActiveRecord::Migration[6.0]
  def change
    remove_column :films, :string, :string
  end
end
