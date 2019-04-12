class CreateAppointment < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :clinician_id
      t.string :cpt_codes_id
      t.string :office_id
      t.string :status, default: 'services'
      t.datetime :start_time

      t.timestamps
    end
  end
end
