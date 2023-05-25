module Rutter
  class Client
    module Accounting # accounting API

      def get_invoices(access_token:)
        get("/accounting/invoices?access_token=#{access_token}")
      end

      def get_invoice(access_token:, rutter_id:)
        get("/accounting/invoices/#{rutter_id}?access_token=#{access_token}")
      end

      def create_invoice(access_token:, body: {})
        post("/accounting/invoices?access_token=#{access_token}", body)
      end

      def get_customers(access_token:)
        get("/accounting/customers?access_token=#{access_token}")
      end

      def get_customer(access_token:, rutter_id:)
        get("/accounting/customers/#{rutter_id}?access_token=#{access_token}")
      end

      # Netsuite functionality should be released soon
      def create_customer(access_token:, body: {})
        post("/accounting/customers?access_token=#{access_token}", body)
      end

      def get_invoice_credit_memos(access_token:)
        get("/accounting/invoice_credit_memos?access_token=#{access_token}")
      end

      def get_invoice_credit_memo(access_token:, rutter_id:)
        get("/accounting/invoice_credit_memos/#{rutter_id}?access_token=#{access_token}")
      end

      def create_invoice_credit_memo(access_token:, body: {})
        post("/accounting/invoice_credit_memos?access_token=#{access_token}", body)
      end

      def get_invoice_payments(access_token:)
        get("/accounting/invoice_payments?access_token=#{access_token}")
      end

      def get_invoice_payment(access_token:, rutter_id:)
        get("/accounting/invoice_payments/#{rutter_id}?access_token=#{access_token}")
      end

      def create_invoice_payment(access_token:, body: {})
        post("/accounting/invoice_payments?access_token=#{access_token}", body)
      end


    end
  end
end
