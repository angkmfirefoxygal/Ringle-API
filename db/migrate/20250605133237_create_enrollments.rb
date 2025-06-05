class CreateEnrollments < ActiveRecord::Migration[8.0]
  def change
    create_table :enrollments do |t|
      t.references :student, null: false, foreign_key: true
      t.references :tutor, null: false, foreign_key: true
      t.datetime :start_time
      t.integer :duration

      t.timestamps
    end
  end
end
