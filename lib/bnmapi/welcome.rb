module BnmAPI
  Welcome = Struct.new(
    :name,
    :api,
    :description,
    :contact,
    :disclaimer
  ) do

    API_PATH = '/welcome'

    def self.get
      http = BnmAPI::HTTP::Client.new(endpoint: API_PATH)

      res = JSON.parse(http.request.read_body)

      self.new(
        res['name'],
        res['api'],
        res['description'],
        res['contact'],
        res['disclaimer']
      )
    end

    def contact_name
      contact['name']
    end

    def contact_email
      contact['email']
    end
  end
end
