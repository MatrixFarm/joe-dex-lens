# JoeDexLens

This repository contains JoeDexLens contract, which purpose is to provide token pricing based on arbitrarily chosen markets.

This contract is not supposed to provide price oracle for any financial operations - should be seen only as helper contract for statistical/analytical purposes.

This contract provides four functions for reading token price:

- `getTokenPriceUSD`
- `getTokensPricesUSD`
- `getTokenPriceAVAX`
- `getTokensPricesAVAX`

To add markets, use the following four functions:

- `addUSDDataFeed`
- `addUSDDataFeeds`
- `addNativeDataFeed`
- `addNativeDataFeeds`

To set the weight of a data feed, use the following four functions:

- `setUSDDataFeedWeight`
- `setUSDDataFeedsWeights`
- `setNativeDataFeedWeight`
- `setNativeDataFeedsWeights`

If no markets for a given token were added, Token-Native and Token-USDC from Joe V2.1, V2 and then V1 will be considered to return the token's price. V2.1 and V2 pairs will be skipped if they don't have enough reserves around the current active bin.

## Deployments

### Fantom

- Owner: 0xB26e6094796e5A4e682807eC8F3044287D8124f5

- JoeDexLens ProxyAdmin: 0x1B6d50395c5AedFCA2BA3CB2022c9be6b7E6a24D
- JoeDexLens Implementation: 0xA4f07649A92425FA6Fd406158EC6B0259772b5DB
- JoeDexLens (behind ERC1967): 0x91EF620AcEE0BA4B62cBC3fB0ae6987583c41916

## Install dependencies

To install dependencies, run the following to install dependencies:

```
forge install
```

---

## Tests

To run tests, run the following command:

```
forge test
```
