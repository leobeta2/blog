class CreateArticles < ActiveRecord::Migration
  def change
  	#es como una pila
    create_table :articles do |t|
      t.string :title
      t.text :body
      t.integer :visits_count

      t.timestamps null: false
    end
  end
end
