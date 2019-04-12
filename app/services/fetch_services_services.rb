require 'json'

class FetchServicesServices
  class << self
    def call
      new.fetch_services
    end
  end

  def fetch_services
    unless services_request.code == 200
      return []
    end

    services_request_data.reduce([]) do |services, service|
      services.push(service) if valid_service?(service)

      services
    end
  end

  private

  def valid_service?(service)
    return false unless service[:id]
    return false unless service[:attributes]
    attributes = service[:attributes]

    return false unless attributes[:description]
    return false unless attributes[:duration]

    true
  end

  def services_request
    @services_request ||= HTTParty.get(
      "#{ENV['CLIENT_PORTAL_BASE_URL']}/client-portal-api/cpt-codes?Accept=application/vnd.api+json&filter[clinicianId]=#{ENV['CLINICIAN_ID']}",
      headers: {
        'Content-Type' => 'application/json',
        'api-version' => '1',
        'application-build-version' => '2',
        'application-platform' => '3'
      }
     )
  end

  def services_request_data
    JSON.parse(services_request.body).with_indifferent_access[:data]
  end
end
