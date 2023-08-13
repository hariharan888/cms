namespace :stock do
  @logger = Logger.new(Rails.root.join('log/stock.rake.log'))

  def get_weekly_params(stock)
    resolution = '1D'
    from = stock.data_available('day')&.to_i || Fetchers::MoneyControl::DEFAULT_FROM
    to = DateTime.now.to_i
    countback = (Time.at(to).to_date - Time.at(from).to_date).to_i

    { resolution:, from:, to:, countback: }
  end

  def seed_stock_values(stock, params)
    data = Fetchers::MoneyControl.get_history(stock.mc_code, **params)
    @logger.info "seed_stock_values: #{stock.id}|#{stock.name} params: #{params} records_count: #{data.count}"

    rdata = data.map do |rec|
      rec.merge({ stock_id: stock.id, resolution: 'day', time: Time.at(rec[:time]).to_datetime })
    end
    StockValue.import rdata,
                      on_duplicate_key_update: { conflict_target: %i[stock_id time resolution],
                                                 columns: %i[open close high low volume] }
  end

  desc 'Seed stock price history for last week'
  task seed_weekly_history: :environment do
    stocks = Stock.includes(:stock_codes).where(stock_codes: { code_type: :mc })
    stocks.each do |stock|
      params = get_weekly_params(stock)
      seed_stock_values(stock, params)
    end
  end
end
