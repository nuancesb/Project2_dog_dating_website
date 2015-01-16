class CreateDogs < ActiveRecord::Migration
  def change
    create_table :dogs do |t|
      t.string :name
      t.references :user, index: true
      t.string  :sex
      t.string  :breed
      t.date    :dob
      t.string  :picture
      t.string  :sound
      t.text    :description

      t.timestamps
    end
  end
end
