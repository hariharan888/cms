require 'open4'

module Fetchers
  module MoneyControl
    HISTORY_CURL = "curl 'https://priceapi.moneycontrol.com/techCharts/indianMarket/stock/history?symbol=%<symbol>s&resolution=%<resolution>s&from=%<from>s&to=%<to>s&countback=%<countback>s&currencyCode=INR' \
    -H 'authority: priceapi.moneycontrol.com' \
    -H 'accept: */*' \
    -H 'accept-language: en-GB,en-US;q=0.9,en;q=0.8,ro;q=0.7' \
    -H 'dnt: 1' \
    -H 'origin: https://www.moneycontrol.com' \
    -H 'referer: https://www.moneycontrol.com/' \
    -H 'sec-ch-ua: \"Not/A)Brand\";v=\"99\", \"Google Chrome\";v=\"115\", \"Chromium\";v=\"115\"' \
    -H 'sec-ch-ua-mobile: ?0' \
    -H 'sec-ch-ua-platform: \"Linux\"' \
    -H 'sec-fetch-dest: empty' \
    -H 'sec-fetch-mode: cors' \
    -H 'sec-fetch-site: same-site' \
    -H 'user-agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36' \
    --compressed".freeze

    HISTORY_DATA_PROPERTIES = %w[s t o h l c v].freeze
    DEFAULT_FROM = 456_537_600
    MAX_COUNTBACK = 9869

    def self.get_history(symbol, resolution: '1D', from: DEFAULT_FROM, to: DateTime.now.to_i, countback: MAX_COUNTBACK)
      command = format(HISTORY_CURL, symbol:, resolution:, from:, to:, countback:)
      result = `#{command}`
      data = JSON.parse(result)
      raise 'Unknown data format' if data.keys.sort != HISTORY_DATA_PROPERTIES.sort

      headers = %i[open close high low volume time]
      [data['o'], data['c'], data['h'], data['l'], data['v'], data['t']].transpose.map do |row|
        headers.zip(row).to_h
      end
    end
  end
end
