# Currency Conversion APP

## Requirements

* [x] Exchange rates must be fetched from: https://currencylayer.com/documentation
* [x] User must be able to select a currency from a list of currencies available from the API
* [x] User should then see a list of exchange rates for the selected currency
* [ ] Rates should be persisted locally and refreshed no more frequently than every 30 minutes (to limit bandwidth usage)

## Design

### UI

#### Templates
CurrencyConversionTemplate : a single top page with a list of currency and a list of exchange rates.

#### Organisms

1. a list of currency
2. a list of exchange rates


#### Molecules
1. dropdown list
2. a cell for displaying exchange rates

#### Atomics
1. CurrencyPairLabel
2. RateLabel

### API
baseUrl : https://apilayer.net/api

#### get Currency Change
path : /live
parameters : 
**access_key** 	[Required] Your API Access Key.
**source** 	[optional] Specify a Source Currency other than the default USD. Supported on the Basic Plan and higher.
**currencies** 	[optional] Specify a comma-separated list of currency codes to limit your API response to specific currencies.

response format: 
```
{
    "success": true,
    "terms": "https://currencylayer.com/terms",
    "privacy": "https://currencylayer.com/privacy",
    "timestamp": 1430401802,
    "source": "USD",
    "quotes": {
        "USDAED": 3.672982,
        "USDAFN": 57.8936,
        "USDALL": 126.1652,
        "USDAMD": 475.306,
        "USDANG": 1.78952,
        "USDAOA": 109.216875,
        "USDARS": 8.901966,
        "USDAUD": 1.269072,
        "USDAWG": 1.792375,
        "USDAZN": 1.04945,
        "USDBAM": 1.757305,
    [...]
    }
}              
```

#### get Supported Currencies
path : /list
query : access_key = YOUR_ACCESS_KEY
response : 
```
{
    "success": true,
    "terms": "https://currencylayer.com/terms",
    "privacy": "https://currencylayer.com/privacy",
    "currencies": {
        "AED": "United Arab Emirates Dirham",
        "AFN": "Afghan Afghani",
        "ALL": "Albanian Lek",
        "AMD": "Armenian Dram",
        "ANG": "Netherlands Antillean Guilder",  
        [...] 
    }
}                       
```

#### Error Codes

```
{
    "success": false,
    "error": {
        "code": 104,
        "info": "Your monthly usage limit has been reached. Please upgrade your subscription plan."    
  }
}               
```

#### cacheテスト
setUp : clear all local file

1. getSupportedCurrencies first time
confirm api called

2. getSupportedCurrencies 15min ago and getSupportedCurrencies second time
confirm api not called and confirm result got

3. getSupportedCurrencies 35min ago and getSupportedCurrencies second time
confirm api called





 
