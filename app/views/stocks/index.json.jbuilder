json.records do
  json.array! @records, partial: 'stocks/stock_summary', as: :stock
end
json.partial! partial: 'commons/pagination', pagy: @pagy
