class Appointment < ApplicationRecord
  module Steps
    CLINICIAN = :clinician
    SERVICES = :services
    OFFICES = :offices
    DATE_AND_TIME = :date_and_time
    YOUR_INFORMATION = :your_information

    ALL = [CLINICIAN, SERVICES, OFFICES, DATE_AND_TIME, YOUR_INFORMATION]
  end

  validates :clinician_id, presence: true, if: :active_or_clinician_id?
  validates :cpt_codes_id, presence: true, if: :active_or_cpt_codes_id?
  validates :office_id, presence: true, if: :active_or_office_id?

  private

  def active?
    status == 'active'
  end

  def active_or_clinician_id?
    status.include?('clinician_id') || active?
  end

  def active_or_cpt_codes_id?
    status.include?('cpt_codes_id') || active?
  end

  def active_or_office_id?
    status.include?('office_id') || active?
  end
end
