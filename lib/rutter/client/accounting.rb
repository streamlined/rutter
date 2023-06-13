module Rutter
  class Client
    module Accounting # accounting API

      def get_invoices(
        access_token:,
        cursor: nil,
        expand: nil,
        force_fetch: false,
        limit: nil,
        updated_at_max: nil,
        updated_at_min: nil
      )
        get("accounting/invoices", {
            access_token: access_token,
            cursor: cursor,
            expand: expand,
            force_fetch: force_fetch,
            limit: limit,
            updated_at_max: updated_at_max,
            updated_at_min: updated_at_min
        }.compact)
      end

      def get_invoice(access_token:, rutter_id:)
        get("accounting/invoices/#{rutter_id}", {
          access_token: access_token,
          force_fetch: false
        })
      end

      def create_invoice(access_token:, body: {})
        post("accounting/invoices?access_token=#{access_token}", body)
      end

      def get_customers(
        access_token:,
        cursor: nil,
        expand: nil,
        force_fetch: false,
        limit: nil,
        updated_at_max: nil,
        updated_at_min: nil
      )
        get("accounting/customers", {
          access_token: access_token,
          cursor: cursor,
          expand: expand,
          force_fetch: force_fetch,
          limit: limit,
          updated_at_max: updated_at_max,
          updated_at_min: updated_at_min
        }.compact)
      end

      def get_customer(access_token:, rutter_id:, force_fetch: false)
        get("accounting/customers/#{rutter_id}", {
          access_token: access_token,
          force_fetch: force_fetch
        }.compact)
      end

      # Netsuite functionality should be released soon
      def create_customer(access_token:, body: {})
        post("accounting/customers?access_token=#{access_token}", body)
      end

      def get_invoice_credit_memos(
        access_token:,
        cursor: nil,
        expand: nil,
        force_fetch: false,
        limit: nil,
        updated_at_max: nil,
        updated_at_min: nil
      )
        get("accounting/invoice_credit_memos", {
          access_token: access_token,
          cursor: cursor,
          expand: expand,
          force_fetch: force_fetch,
          limit: limit,
          updated_at_max: updated_at_max,
          updated_at_min: updated_at_min
        }.compact)
      end

      def get_invoice_credit_memo(access_token:, rutter_id:, force_fetch: false)
        get("accounting/invoice_credit_memos/#{rutter_id}", {
          access_token: access_token,
          force_fetch: force_fetch
        }.compact)
      end

      def create_invoice_credit_memo(access_token:, body: {})
        post("accounting/invoice_credit_memos?access_token=#{access_token}", body)
      end

      def get_invoice_payments(
        access_token:,
        cursor: nil,
        expand: nil,
        force_fetch: false,
        limit: nil,
        updated_at_max: nil,
        updated_at_min: nil
      )
        get("accounting/invoice_payments", {
          access_token: access_token,
          cursor: cursor,
          expand: expand,
          force_fetch: force_fetch,
          limit: limit,
          updated_at_max: updated_at_max,
          updated_at_min: updated_at_min
        }.compact)
      end

      def get_invoice_payment(access_token:, rutter_id:, force_fetch: false)
        get("accounting/invoice_payments/#{rutter_id}", {
          access_token: access_token,
          force_fetch: force_fetch
        }.compact)
      end

      def create_invoice_payment(access_token:, body: {})
        post("accounting/invoice_payments?access_token=#{access_token}", body)
      end

      def get_sales_orders(
        access_token:,
        cursor: nil,
        expand: nil,
        force_fetch: false,
        limit: nil,
        updated_at_max: nil,
        updated_at_min: nil
      )
        get("accounting/sales_orders", {
          access_token: access_token,
          cursor: cursor,
          expand: expand,
          force_fetch: force_fetch,
          limit: limit,
          updated_at_max: updated_at_max,
          updated_at_min: updated_at_min
        }.compact)
      end

      def get_sales_order(access_token:, rutter_id:, force_fetch: false)
        get("accounting/sales_orders/#{rutter_id}", {
          access_token: access_token,
          force_fetch: force_fetch
        }.compact)
      end

      def create_sales_order(access_token:, body: {})
        post("accounting/sales_orders?access_token=#{access_token}", body)
      end

      def get_accounts(
        access_token:,
        cursor: nil,
        expand: nil,
        force_fetch: false,
        limit: nil,
        updated_at_max: nil,
        updated_at_min: nil
      )
        get("accounting/accounts", {
          access_token: access_token,
          cursor: cursor,
          expand: expand,
          force_fetch: force_fetch,
          limit: limit,
          updated_at_max: updated_at_max,
          updated_at_min: updated_at_min
        }.compact)
      end

      def get_account(access_token:, rutter_id:, force_fetch: false)
        get("accounting/accounts/#{rutter_id}", {
          access_token: access_token,
          force_fetch: force_fetch
        }.compact)
      end

      def get_items(
        access_token:,
        cursor: nil,
        expand: nil,
        force_fetch: false,
        limit: nil,
        updated_at_max: nil,
        updated_at_min: nil)
        get("accounting/items", {
          access_token: access_token,
          cursor: cursor,
          expand: expand,
          force_fetch: force_fetch,
          limit: limit,
          updated_at_max: updated_at_max,
          updated_at_min: updated_at_min
        }.compact)
      end

      def get_item(access_token:, rutter_id:, force_fetch: false)
        get("accounting/items/#{rutter_id}", {
          access_token: access_token,
          force_fetch: force_fetch
        }.compact)
      end
    end
  end
end
