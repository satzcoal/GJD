json.array!(@info_customer_fin_dtls) do |info_customer_fin_dtl|
  json.extract! info_customer_fin_dtl, :id, :customer_fin_id, :do_time, :in_or_out, :money, :cfd_id, :status_id
  json.url info_customer_fin_dtl_url(info_customer_fin_dtl, format: :json)
end
