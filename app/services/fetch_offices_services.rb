require 'json'

class FetchOfficesServices
  attr_accessor :cpt_codes_id

  def initialize(cpt_codes_id)
    self.cpt_codes_id = cpt_codes_id
  end

  class << self
    def call(cpt_codes_id)
      new(cpt_codes_id).fetch_offices
    end
  end

  def fetch_offices
    unless offices_request.code == 200
      return []
    end

    offices_request_data.reduce([]) do |offices, office|
      offices.push(office) if valid_office?(office)

      offices
    end
  end

  private

  def valid_office?(office)
    return false unless office[:id]
    return false unless office[:attributes]
    attributes = office[:attributes]

    return false unless attributes[:name]
    return false unless attributes[:street]
    return false unless attributes[:city]
    return false unless attributes[:state]
    return false unless attributes[:zip]
    return false unless attributes[:phone]

    true
  end

  def offices_request
    @offices_request ||= HTTParty.get(
      "#{ENV['CLIENT_PORTAL_BASE_URL']}/client-portal-api/offices?Accept=application/vnd.api+json&filter[clinicianId]=#{ENV['CLINICIAN_ID']}&filter[cptCodeId]=#{cpt_codes_id}",
      headers: {
        'Content-Type' => 'application/json',
        'api-version' => '1',
        'application-build-version' => '2',
        'application-platform' => '3'
      }
     )
  end

  def offices_request_data
    JSON.parse(offices_request.body).with_indifferent_access[:data]
  end
end
