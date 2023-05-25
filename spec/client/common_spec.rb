RSpec.describe Rutter::Client::Common do
  let!(:client) {
    Rutter::Client.new(
      api_base_url: "https://production.rutterapi.com"
    )
  }

  let(:access_token) { "<access_token>" }

  context 'methods' do
    describe 'get_connections' do
      it 'should return a list of connections with the correct attributes' do
        # NOTE: VCR file intentionally not committed to avoid exposing credentials
        VCR.use_cassette('get_connections') do
          response = client.get_connections
          expect(response).to have_key("connections")
          response = response["connections"]
          expect(response).to be_a(Array)
          connection = response[0]
          expect(connection).to be_a(Hash)
          expect(connection).to have_key("id")
          expect(connection).to have_key("access_token")
          expect(connection).to have_key("platform")
          expect(connection).to have_key("link_url")
          expect(connection).to have_key("created_at")
          expect(connection).to have_key("updated_at")
        end
      end
    end

    describe 'get_connection' do
      it 'should return connection with the correct attributes' do
        # NOTE: VCR file intentionally not committed to avoid exposing credentials
        VCR.use_cassette('get_connection') do
          response = client.get_connection(access_token: access_token)
          expect(response).to be_a(Hash)
          connection = response["connection"]
          expect(connection).to have_key("id")
          expect(connection).to have_key("store_unique_id")
          expect(connection).to have_key("needs_update")
          expect(connection).to have_key("disabled")
          expect(connection).to have_key("disabled_reason")
          expect(connection).to have_key("link_url")
          expect(connection).to have_key("last_sync_completed_at")
          expect(connection).to have_key("last_sync_started_at")
          expect(connection).to have_key("platform")
        end
      end
    end
  end
end
