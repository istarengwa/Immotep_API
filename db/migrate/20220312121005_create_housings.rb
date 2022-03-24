class CreateHousings < ActiveRecord::Migration[7.0]
  def change
    create_table :housings do |t|
      t.integer :ad_price
      t.string :property_category
      t.string :localization
      t.integer :area
      t.string :ad_url
      t.text :comment
      t.integer :offer_price
      t.integer :repairs_price
      t.integer :annual_rent
      t.float :notary_fees
      t.integer :agency_fees
      t.boolean :pno_insurance
      t.integer :property_tax
      t.boolean :rental_management
      t.boolean :rental_unpayment_insurance
      t.integer :building_co_tax
      t.float :maintenance_percentage
      t.float :ad_profitability
      t.float :offer_profitability
      t.boolean :new_property
      t.float :rental_vacancy

      t.timestamps
    end
  end
end
