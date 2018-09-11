# Mobius DApp Store Unity IOS SDK

The Mobius DApp Store Unity iOS sdk makes it easy to integrate Mobius DApp Store MOBI payments into any unity iOS application.

A big advantage of the Mobius DApp Store over centralized competitors such as the Apple App Store or Google Play Store is significantly lower fees - currently 0% compared to 30% - for in-app purchases.

## DApp Store Overview

The Mobius DApp Store will be an open-source, non-custodial "wallet" interface for easily sending crypto payments to apps. You can think of the DApp Store like https://stellarterm.com/ or https://www.myetherwallet.com/ but instead of a wallet interface it is an App Store interface.

The DApp Store is non-custodial meaning Mobius never holds the secret key of either the user or developer.

An overview of the DApp Store architecture is:

- Every application holds the private key for the account where it receives MOBI.
- An application specific unique account where a user deposits MOBI for use with the application is generated for each app based on the user's seed phrase.
- When a user opens an app through the DApp Store:
  1) Adds the application's public key as a signer so the application can access the MOBI and
  2) Signs a challenge transaction from the app with its secret key to authenticate that this user owns the account. This prevents a different person from pretending they own the account and spending the MOBI (more below under Authentication).
  
## Installation

Convert your Unity Project Platform to iOS. 
Then open the UnityPackage that is in the github repo and you're good to go

## Authentication

### Explanation

When a user opens an app through the DApp Store it tells the app what Mobius account it should use for payment.

The application needs to ensure that the user actually owns the secret key to the Mobius account and that this isn't a replay attack from a user who captured a previous request and is replaying it.

This authentication is accomplished through the following process:

* When the user opens an app in the DApp Store it requests a challenge from the application.
* The challenge is a payment transaction of 1 XLM from and to the application account. It is never sent to the network - it is just used for authentication.
* The application generates the challenge transaction on request, signs it with its own private key, and sends it to user.
* The user receives the challenge transaction and verifies it is signed by the application's secret key by checking it against the application's published public key (that it receives through the DApp Store). Then the user signs the transaction with its own private key and sends it back to application along with its public key.
* Application checks that challenge transaction is now signed by itself and the public key that was passed in. Time bounds are also checked to make sure this isn't a replay attack. If everything passes the server replies with a token the application can pass in to "login" with the specified public key and use it for payment (it would have previously given the app access to the public key by adding the app's public key as a signer).

Note: the challenge transaction also has time bounds to restrict the time window when it can be used.


### Sample Implementation

```unity
To create test account Call this from Unity anywhere
MobiusUnity.CreateAccount("false");

To create live account Call this from Unity anywhere
MobiusUnity.CreateAccount("true");

This function will return JSON string like this and you can parse it according to your requirement

if there is no error
{
"publicKey":"12455",
"secretkey":"23455",
"error":"NO"
}

if there is some sort of error
{
"publicKey":"12455",
"secretkey":"23455",
"error":"Network Failure"
}

```

## Payment

### Explanation

After the user completes the authentication process they have a secret key. 

### Sample Implementation

```Unity
MobiusUnity.SendPayment(string publicKey , string secretKey , string amount , string status);

i.e status = "true" for public Testnet
    status = "false" for test account
    
This function will return JSON string like this and you can parse it according to your requirement

if there is no error
{
"balance":"12455",
"error":"NO"
}

if there is some sort of error
{
"balance":"12455",
"error":"Network Failure"
}
 
```

## GetBalance

### Sample Implementation

```Unity
MobiusUnity.getBalance(string secretKey , string status);

i.e status = "true" for public Testnet
    status = "false" for test account
    
    
This function will return JSON string like this and you can parse it according to your requirement

if there is no error
{
"balance":"12455",
"error":"NO"
}

if there is some sort of error
{
"balance":"12455",
"error":"Network Failure"
}
      
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mobius-network/mobius-client-unity. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The SDK is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
