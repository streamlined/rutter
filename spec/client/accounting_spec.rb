RSpec.describe Rutter::Client::Accounting do
  let!(:client) {
    Rutter::Client.new(
      api_base_url: "https://production.rutterapi.com"
    )
  }

  let(:access_token) { "<access_token>" }

  context 'methods' do
    describe 'get_invoices' do
      it 'should return a list of invoices with the correct attributes' do
        VCR.use_cassette('get_invoices') do
          response = client.get_invoices(access_token: access_token)
          expect(response).to have_key("connection")
          expect(response).to have_key("invoices")
          response = response["invoices"]
          expect(response).to be_a(Array)
          invoice = response[0]
          expect(invoice).to be_a(Hash)
          expect(invoice).to have_key("id")
          expect(invoice).to have_key("platform_id")
          expect(invoice).to have_key("customer_id")
          expect(invoice).to have_key("issue_date")
          expect(invoice).to have_key("due_date")
          expect(invoice).to have_key("currency_code")
          expect(invoice).to have_key("total_amount")
          expect(invoice).to have_key("sub_total")
          expect(invoice).to have_key("total_discount")
          expect(invoice).to have_key("amount_due")
          expect(invoice).to have_key("line_items")
          expect(invoice).to have_key("linked_payments")
          expect(invoice).to have_key("status")
        end
      end
    end

    describe 'get_invoice' do
      let(:rutter_id) { "bc02d284-7d24-44ed-8060-7a49bf1ab071" }

      it 'should return a list of invoices with the correct attributes' do
        VCR.use_cassette('get_invoice') do
          response = client.get_invoice(access_token: access_token, rutter_id: rutter_id)
          expect(response).to be_a(Hash)
          invoice = response["invoice"]
          expect(invoice).to have_key("id")
          expect(invoice).to have_key("platform_id")
          expect(invoice).to have_key("customer_id")
          expect(invoice).to have_key("issue_date")
          expect(invoice).to have_key("due_date")
          expect(invoice).to have_key("currency_code")
          expect(invoice).to have_key("total_amount")
          expect(invoice).to have_key("sub_total")
          expect(invoice).to have_key("total_discount")
          expect(invoice).to have_key("amount_due")
          expect(invoice).to have_key("line_items")
          expect(invoice).to have_key("linked_payments")
          expect(invoice).to have_key("status")
        end
      end
    end

    describe 'create_invoice' do
      let(:body) do
        {
          "invoice": {
            "customer_id": "25c94fdb-4426-42d9-b7f6-f541593e83cd",
            "due_date": "2023-10-25T02:34:56.000Z",
            "issue_date": "2023-01-25T02:34:56.000Z",
            "currency_code": "USD",
            "line_items": [
              {
                "total_amount": 50000,
                "description": "From rutter rspec",
                "item": {
                  "id": "721f36b0-d654-4084-b318-0d9341411be6",
                  "quantity": 50000,
                  "unit_amount": 1
                }
              }
            ]
          }
        }
      end

      it 'should return an invoice with the correct attributes' do
        VCR.use_cassette('create_invoice') do
          response = client.create_invoice(access_token: access_token, body: body)
          expect(response).to be_a(Hash)
          invoice = response["invoice"]
          expect(invoice).to have_key("id")
          expect(invoice).to have_key("platform_id")
          expect(invoice).to have_key("customer_id")
          expect(invoice).to have_key("issue_date")
          expect(invoice).to have_key("due_date")
          expect(invoice).to have_key("currency_code")
          expect(invoice).to have_key("total_amount")
          expect(invoice).to have_key("sub_total")
          expect(invoice).to have_key("total_discount")
          expect(invoice).to have_key("amount_due")
          expect(invoice).to have_key("line_items")
          expect(invoice).to have_key("linked_payments")
          expect(invoice).to have_key("status")
        end
      end
    end

    describe 'get_customers' do
      it 'should return a list of customers with the correct attributes' do
        VCR.use_cassette('get_customers') do
          response = client.get_customers(access_token: access_token)
          expect(response).to have_key("connection")
          expect(response).to have_key("customers")
          response = response["customers"]
          expect(response).to be_a(Array)
          customer = response[0]
          expect(customer).to be_a(Hash)
          expect(customer).to have_key("id")
          expect(customer).to have_key("platform_id")
          expect(customer).to have_key("customer_name")
          expect(customer).to have_key("contact_name")
          expect(customer).to have_key("email")
          expect(customer).to have_key("currency_code")
          expect(customer).to have_key("phone")
          expect(customer).to have_key("addresses")
          expect(customer).to have_key("registration_number")
          expect(customer).to have_key("tax_number")
          expect(customer).to have_key("updated_at")
          expect(customer).to have_key("status")
        end
      end
    end

    describe 'get_customer' do
      let(:rutter_id) { "00144897-32bb-4e78-8946-1937ebdfef94" }

      it 'should return a customer with the correct attributes' do
        VCR.use_cassette('get_customer') do
          response = client.get_customer(access_token: access_token, rutter_id: rutter_id)
          expect(response).to be_a(Hash)
          customer = response["customer"]
          expect(customer).to be_a(Hash)
          expect(customer).to have_key("id")
          expect(customer).to have_key("platform_id")
          expect(customer).to have_key("customer_name")
          expect(customer).to have_key("contact_name")
          expect(customer).to have_key("email")
          expect(customer).to have_key("currency_code")
          expect(customer).to have_key("phone")
          expect(customer).to have_key("addresses")
          expect(customer).to have_key("registration_number")
          expect(customer).to have_key("tax_number")
          expect(customer).to have_key("updated_at")
          expect(customer).to have_key("status")
        end
      end
    end

    # TODO: uncomment once netsuite create customers is live
    # describe 'create_customer' do
    #   let(:body) do
    #     {
    #       "customer": {
    #         "contact_name": "Bob Boblaw",
    #         "customer_name": "Rutter rspec",
    #         "email": "bob@rutter.com",
    #         "phone": "1234567890",
    #         "registration_number": "123456789",
    #         "tax_number": "12-3456789",
    #         "addresses": [
    #           {
    #             "type": "billing",
    #             "address1": "123 Rutter Road",
    #             "address2": "Floor 4",
    #             "city": "San Francisco",
    #             "country": "USA",
    #             "postal_code": "94110",
    #             "region": "CA"
    #           }
    #         ]
    #       }
    #     }
    #   end

    #   it 'should return a customer with the correct attributes' do
    #     VCR.use_cassette('create_customer') do
    #       response = client.create_customer(access_token: access_token, body: body)
    #       expect(response).to be_a(Hash)
    #       customer = response["customer"]
    #       expect(customer).to be_a(Hash)
    #       expect(customer).to have_key("id")
    #       expect(customer).to have_key("platform_id")
    #       expect(customer).to have_key("customer_name")
    #       expect(customer).to have_key("contact_name")
    #       expect(customer).to have_key("email")
    #       expect(customer).to have_key("currency_code")
    #       expect(customer).to have_key("phone")
    #       expect(customer).to have_key("addresses")
    #       expect(customer).to have_key("registration_number")
    #       expect(customer).to have_key("tax_number")
    #       expect(customer).to have_key("updated_at")
    #       expect(customer).to have_key("status")
    #     end
    #   end
    # end

    describe 'get_invoice_payments' do
      it 'should return a list of invoice_payments with the correct attributes' do
        VCR.use_cassette('get_invoice_payments') do
          response = client.get_invoice_payments(access_token: access_token)
          expect(response).to have_key("connection")
          expect(response).to have_key("invoice_payments")
          response = response["invoice_payments"]
          expect(response).to be_a(Array)
          invoice_payment = response[0]
          expect(invoice_payment).to be_a(Hash)
          expect(invoice_payment).to have_key("id")
          expect(invoice_payment).to have_key("platform_id")
          expect(invoice_payment).to have_key("customer_id")
          expect(invoice_payment).to have_key("account_id")
          expect(invoice_payment).to have_key("total_amount")
          expect(invoice_payment).to have_key("currency_code")
          expect(invoice_payment).to have_key("txn_date")
          expect(invoice_payment).to have_key("memo")
          expect(invoice_payment).to have_key("linked_invoices")
          expect(invoice_payment).to have_key("updated_at")
        end
      end
    end

    describe 'get_invoice_payment' do
      let(:rutter_id) { "98f05d4c-3e8d-456c-9257-e2f0ddc0e8b7" }

      it 'should return a list of invoices with the correct attributes' do
        VCR.use_cassette('get_invoice_payment') do
          response = client.get_invoice_payment(access_token: access_token, rutter_id: rutter_id)
          expect(response).to be_a(Hash)
          invoice_payment = response["invoice_payment"]
          expect(invoice_payment).to be_a(Hash)
          expect(invoice_payment).to have_key("id")
          expect(invoice_payment).to have_key("platform_id")
          expect(invoice_payment).to have_key("customer_id")
          expect(invoice_payment).to have_key("account_id")
          expect(invoice_payment).to have_key("total_amount")
          expect(invoice_payment).to have_key("currency_code")
          expect(invoice_payment).to have_key("txn_date")
          expect(invoice_payment).to have_key("memo")
          expect(invoice_payment).to have_key("linked_invoices")
          expect(invoice_payment).to have_key("updated_at")
        end
      end
    end

    describe 'create_invoice' do
      let(:body) do
        {
          "invoice_payment": {
              "customer_id": "25c94fdb-4426-42d9-b7f6-f541593e83cd",
              "account_id": "7efd4004-4b3f-469b-99dc-9930bb1b7134",
              "total_amount": 2,
              "currency_code": "USD",
              "txn_date": "2023-05-20T02:34:56.000Z",
              "memo": "a memo",
              "linked_invoices": [{
                  "id": "3953eb49-5818-499b-ab47-b9abd76b4053",
                  "amount": 2,
                  "allocated_at": "2023-05-20T02:34:56.000Z"
              }]
          }
        }
      end

      it 'should return an invoice with the correct attributes' do
        VCR.use_cassette('create_invoice') do
          response = client.create_invoice(access_token: access_token, body: body)
          expect(response).to be_a(Hash)
          invoice = response["invoice"]
          expect(invoice).to have_key("id")
          expect(invoice).to have_key("platform_id")
          expect(invoice).to have_key("customer_id")
          expect(invoice).to have_key("issue_date")
          expect(invoice).to have_key("due_date")
          expect(invoice).to have_key("currency_code")
          expect(invoice).to have_key("total_amount")
          expect(invoice).to have_key("sub_total")
          expect(invoice).to have_key("total_discount")
          expect(invoice).to have_key("amount_due")
          expect(invoice).to have_key("line_items")
          expect(invoice).to have_key("linked_payments")
          expect(invoice).to have_key("status")
        end
      end
    end

    describe 'get_customers' do
      it 'should return a list of invoices with the correct attributes' do
        VCR.use_cassette('get_customers') do
          response = client.get_customers(access_token: access_token)
          expect(response).to have_key("connection")
          expect(response).to have_key("customers")
          response = response["customers"]
          expect(response).to be_a(Array)
          customer = response[0]
          expect(customer).to be_a(Hash)
          expect(customer).to have_key("id")
          expect(customer).to have_key("platform_id")
          expect(customer).to have_key("customer_name")
          expect(customer).to have_key("contact_name")
          expect(customer).to have_key("email")
          expect(customer).to have_key("currency_code")
          expect(customer).to have_key("phone")
          expect(customer).to have_key("addresses")
          expect(customer).to have_key("registration_number")
          expect(customer).to have_key("tax_number")
          expect(customer).to have_key("updated_at")
          expect(customer).to have_key("status")
        end
      end
    end

  end
end
