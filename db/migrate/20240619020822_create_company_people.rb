class CreateCompanyPeople < ActiveRecord::Migration[7.0]
  def change
    create_table :company_people do |t|
      t.belongs_to :person, null: false, foreign_key: true
      t.belongs_to :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
