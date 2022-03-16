//
//  Orders.swift
//  eShtry
//
//  Created by eslam mohamed on 16/03/2022.
//

import Foundation

struct Orders:Codable{
    
    struct Orders : Codable {
        let id : Int?
        let admin_graphql_api_id : String?
        let app_id : Int?
        let browser_ip : String?
        let buyer_accepts_marketing : Bool?
        let cancel_reason : String?
        let cancelled_at : String?
        let cart_token : String?
        let checkout_id : String?
        let checkout_token : String?
        let closed_at : String?
        let confirmed : Bool?
        let contact_email : String?
        let created_at : String?
        let currency : String?
        let current_subtotal_price : String?
        let current_subtotal_price_set : CurrentSubtotalPriceSet?
        let current_total_discounts : String?
        let current_total_discounts_set : CurrentTotalDiscountsSet?
        let current_total_duties_set : String?
        let current_total_price : String?
        let current_total_price_set : CurrentTotalPriceSet?
        let current_total_tax : String?
        let current_total_tax_set : CurrentTotalTaxSet?
        let customer_locale : String?
        let device_id : String?
        let discount_codes : [String]?
        let email : String?
        let estimated_taxes : Bool?
        let financial_status : String?
        let fulfillment_status : String?
        let gateway : String?
        let landing_site : String?
        let landing_site_ref : String?
        let location_id : String?
        let name : String?
        let note : String?
        let note_attributes : [String]?
        let number : Int?
        let order_number : Int?
        let order_status_url : String?
        let original_total_duties_set : String?
        let payment_gateway_names : [String]?
        let phone : String?
        let presentment_currency : String?
        let processed_at : String?
        let processing_method : String?
        let reference : String?
        let referring_site : String?
        let source_identifier : String?
        let source_name : String?
        let source_url : String?
        let subtotal_price : String?
        let subtotal_price_set : SubtotalPriceSet?
        let tags : String?
        let tax_lines : [String]?
        let taxes_included : Bool?
        let test : Bool?
        let token : String?
        let total_discounts : String?
        let total_discounts_set : TotalDiscountsSet?
        let total_line_items_price : String?
        let total_line_items_price_set : TotalLineItemsPriceSet?
        let total_outstanding : String?
        let total_price : String?
        let total_price_set : TotalPriceSet?
        let total_price_usd : String?
        let total_shipping_price_set : TotalShippingPriceSet?
        let total_tax : String?
        let total_tax_set : TotalTaxSet?
        let total_tip_received : String?
        let total_weight : Int?
        let updated_at : String?
        let user_id : String?
        let customer : Customer?
        let discount_applications : [String]?
        let fulfillments : [String]?
        let line_items : [LineItems]?
        let payment_terms : String?
        let refunds : [String]?
        let shipping_lines : [String]?

        enum CodingKeys: String, CodingKey {

            case id = "id"
            case admin_graphql_api_id = "admin_graphql_api_id"
            case app_id = "app_id"
            case browser_ip = "browser_ip"
            case buyer_accepts_marketing = "buyer_accepts_marketing"
            case cancel_reason = "cancel_reason"
            case cancelled_at = "cancelled_at"
            case cart_token = "cart_token"
            case checkout_id = "checkout_id"
            case checkout_token = "checkout_token"
            case closed_at = "closed_at"
            case confirmed = "confirmed"
            case contact_email = "contact_email"
            case created_at = "created_at"
            case currency = "currency"
            case current_subtotal_price = "current_subtotal_price"
            case current_subtotal_price_set = "current_subtotal_price_set"
            case current_total_discounts = "current_total_discounts"
            case current_total_discounts_set = "current_total_discounts_set"
            case current_total_duties_set = "current_total_duties_set"
            case current_total_price = "current_total_price"
            case current_total_price_set = "current_total_price_set"
            case current_total_tax = "current_total_tax"
            case current_total_tax_set = "current_total_tax_set"
            case customer_locale = "customer_locale"
            case device_id = "device_id"
            case discount_codes = "discount_codes"
            case email = "email"
            case estimated_taxes = "estimated_taxes"
            case financial_status = "financial_status"
            case fulfillment_status = "fulfillment_status"
            case gateway = "gateway"
            case landing_site = "landing_site"
            case landing_site_ref = "landing_site_ref"
            case location_id = "location_id"
            case name = "name"
            case note = "note"
            case note_attributes = "note_attributes"
            case number = "number"
            case order_number = "order_number"
            case order_status_url = "order_status_url"
            case original_total_duties_set = "original_total_duties_set"
            case payment_gateway_names = "payment_gateway_names"
            case phone = "phone"
            case presentment_currency = "presentment_currency"
            case processed_at = "processed_at"
            case processing_method = "processing_method"
            case reference = "reference"
            case referring_site = "referring_site"
            case source_identifier = "source_identifier"
            case source_name = "source_name"
            case source_url = "source_url"
            case subtotal_price = "subtotal_price"
            case subtotal_price_set = "subtotal_price_set"
            case tags = "tags"
            case tax_lines = "tax_lines"
            case taxes_included = "taxes_included"
            case test = "test"
            case token = "token"
            case total_discounts = "total_discounts"
            case total_discounts_set = "total_discounts_set"
            case total_line_items_price = "total_line_items_price"
            case total_line_items_price_set = "total_line_items_price_set"
            case total_outstanding = "total_outstanding"
            case total_price = "total_price"
            case total_price_set = "total_price_set"
            case total_price_usd = "total_price_usd"
            case total_shipping_price_set = "total_shipping_price_set"
            case total_tax = "total_tax"
            case total_tax_set = "total_tax_set"
            case total_tip_received = "total_tip_received"
            case total_weight = "total_weight"
            case updated_at = "updated_at"
            case user_id = "user_id"
            case customer = "customer"
            case discount_applications = "discount_applications"
            case fulfillments = "fulfillments"
            case line_items = "line_items"
            case payment_terms = "payment_terms"
            case refunds = "refunds"
            case shipping_lines = "shipping_lines"
        }

        init(from decoder: Decoder) throws {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            id = try values.decodeIfPresent(Int.self, forKey: .id)
            admin_graphql_api_id = try values.decodeIfPresent(String.self, forKey: .admin_graphql_api_id)
            app_id = try values.decodeIfPresent(Int.self, forKey: .app_id)
            browser_ip = try values.decodeIfPresent(String.self, forKey: .browser_ip)
            buyer_accepts_marketing = try values.decodeIfPresent(Bool.self, forKey: .buyer_accepts_marketing)
            cancel_reason = try values.decodeIfPresent(String.self, forKey: .cancel_reason)
            cancelled_at = try values.decodeIfPresent(String.self, forKey: .cancelled_at)
            cart_token = try values.decodeIfPresent(String.self, forKey: .cart_token)
            checkout_id = try values.decodeIfPresent(String.self, forKey: .checkout_id)
            checkout_token = try values.decodeIfPresent(String.self, forKey: .checkout_token)
            closed_at = try values.decodeIfPresent(String.self, forKey: .closed_at)
            confirmed = try values.decodeIfPresent(Bool.self, forKey: .confirmed)
            contact_email = try values.decodeIfPresent(String.self, forKey: .contact_email)
            created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
            currency = try values.decodeIfPresent(String.self, forKey: .currency)
            current_subtotal_price = try values.decodeIfPresent(String.self, forKey: .current_subtotal_price)
            current_subtotal_price_set = try values.decodeIfPresent(CurrentSubtotalPriceSet.self, forKey: .current_subtotal_price_set)
            current_total_discounts = try values.decodeIfPresent(String.self, forKey: .current_total_discounts)
            current_total_discounts_set = try values.decodeIfPresent(CurrentTotalDiscountsSet.self, forKey: .current_total_discounts_set)
            current_total_duties_set = try values.decodeIfPresent(String.self, forKey: .current_total_duties_set)
            current_total_price = try values.decodeIfPresent(String.self, forKey: .current_total_price)
            current_total_price_set = try values.decodeIfPresent(CurrentTotalPriceSet.self, forKey: .current_total_price_set)
            current_total_tax = try values.decodeIfPresent(String.self, forKey: .current_total_tax)
            current_total_tax_set = try values.decodeIfPresent(CurrentTotalTaxSet.self, forKey: .current_total_tax_set)
            customer_locale = try values.decodeIfPresent(String.self, forKey: .customer_locale)
            device_id = try values.decodeIfPresent(String.self, forKey: .device_id)
            discount_codes = try values.decodeIfPresent([String].self, forKey: .discount_codes)
            email = try values.decodeIfPresent(String.self, forKey: .email)
            estimated_taxes = try values.decodeIfPresent(Bool.self, forKey: .estimated_taxes)
            financial_status = try values.decodeIfPresent(String.self, forKey: .financial_status)
            fulfillment_status = try values.decodeIfPresent(String.self, forKey: .fulfillment_status)
            gateway = try values.decodeIfPresent(String.self, forKey: .gateway)
            landing_site = try values.decodeIfPresent(String.self, forKey: .landing_site)
            landing_site_ref = try values.decodeIfPresent(String.self, forKey: .landing_site_ref)
            location_id = try values.decodeIfPresent(String.self, forKey: .location_id)
            name = try values.decodeIfPresent(String.self, forKey: .name)
            note = try values.decodeIfPresent(String.self, forKey: .note)
            note_attributes = try values.decodeIfPresent([String].self, forKey: .note_attributes)
            number = try values.decodeIfPresent(Int.self, forKey: .number)
            order_number = try values.decodeIfPresent(Int.self, forKey: .order_number)
            order_status_url = try values.decodeIfPresent(String.self, forKey: .order_status_url)
            original_total_duties_set = try values.decodeIfPresent(String.self, forKey: .original_total_duties_set)
            payment_gateway_names = try values.decodeIfPresent([String].self, forKey: .payment_gateway_names)
            phone = try values.decodeIfPresent(String.self, forKey: .phone)
            presentment_currency = try values.decodeIfPresent(String.self, forKey: .presentment_currency)
            processed_at = try values.decodeIfPresent(String.self, forKey: .processed_at)
            processing_method = try values.decodeIfPresent(String.self, forKey: .processing_method)
            reference = try values.decodeIfPresent(String.self, forKey: .reference)
            referring_site = try values.decodeIfPresent(String.self, forKey: .referring_site)
            source_identifier = try values.decodeIfPresent(String.self, forKey: .source_identifier)
            source_name = try values.decodeIfPresent(String.self, forKey: .source_name)
            source_url = try values.decodeIfPresent(String.self, forKey: .source_url)
            subtotal_price = try values.decodeIfPresent(String.self, forKey: .subtotal_price)
            subtotal_price_set = try values.decodeIfPresent(SubtotalPriceSet.self, forKey: .subtotal_price_set)
            tags = try values.decodeIfPresent(String.self, forKey: .tags)
            tax_lines = try values.decodeIfPresent([String].self, forKey: .tax_lines)
            taxes_included = try values.decodeIfPresent(Bool.self, forKey: .taxes_included)
            test = try values.decodeIfPresent(Bool.self, forKey: .test)
            token = try values.decodeIfPresent(String.self, forKey: .token)
            total_discounts = try values.decodeIfPresent(String.self, forKey: .total_discounts)
            total_discounts_set = try values.decodeIfPresent(TotalDiscountsSet.self, forKey: .total_discounts_set)
            total_line_items_price = try values.decodeIfPresent(String.self, forKey: .total_line_items_price)
            total_line_items_price_set = try values.decodeIfPresent(TotalLineItemsPriceSet.self, forKey: .total_line_items_price_set)
            total_outstanding = try values.decodeIfPresent(String.self, forKey: .total_outstanding)
            total_price = try values.decodeIfPresent(String.self, forKey: .total_price)
            total_price_set = try values.decodeIfPresent(TotalPriceSet.self, forKey: .total_price_set)
            total_price_usd = try values.decodeIfPresent(String.self, forKey: .total_price_usd)
            total_shipping_price_set = try values.decodeIfPresent(TotalShippingPriceSet.self, forKey: .total_shipping_price_set)
            total_tax = try values.decodeIfPresent(String.self, forKey: .total_tax)
            total_tax_set = try values.decodeIfPresent(TotalTaxSet.self, forKey: .total_tax_set)
            total_tip_received = try values.decodeIfPresent(String.self, forKey: .total_tip_received)
            total_weight = try values.decodeIfPresent(Int.self, forKey: .total_weight)
            updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
            user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
            customer = try values.decodeIfPresent(Customer.self, forKey: .customer)
            discount_applications = try values.decodeIfPresent([String].self, forKey: .discount_applications)
            fulfillments = try values.decodeIfPresent([String].self, forKey: .fulfillments)
            line_items = try values.decodeIfPresent([LineItems].self, forKey: .line_items)
            payment_terms = try values.decodeIfPresent(String.self, forKey: .payment_terms)
            refunds = try values.decodeIfPresent([String].self, forKey: .refunds)
            shipping_lines = try values.decodeIfPresent([String].self, forKey: .shipping_lines)
        }

    }
}
