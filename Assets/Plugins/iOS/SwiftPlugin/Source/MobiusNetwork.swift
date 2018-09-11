

import Foundation
import UIKit


@objc public class MobiusNetwork: UIViewController {
    @objc static let shared = MobiusNetwork()
    var loopstatus = true
    var responseBool = true
    @objc func SayHiToUnity() -> String{
         var returnStr = ""
        let jsonObject: [String: Any] = [
            "error": "200",
            "message" : "Hi, I'm Swift"
        ]
        if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
            let str = String(data: data, encoding: .utf8) {
            print(str)
            returnStr = str
        }
        return returnStr
    }
    
    @objc func CreateAccount(status : String) -> String{
        var returnStr = ""
        self.loopstatus = true
        self.responseBool = true
       
        repeat
        {
            
            if(self.loopstatus)
            {
                self.loopstatus = false
                let account = StellarSDK.Account.random()
//                if(status == "true")
//                {
//                    account.useNetwork(.live)
//                    account.usePublicNetwork()
//                }
//                else
//                {
//
//                }
                account.useNetwork(.test)
                account.useTestNetwork()
                account.friendbot { (true) in
                    account.getInfo { response in
                        print(response.balances)
                        let jsonObject: [String: Any] = [
                            "publicKey":account.publicKey ,
                            "secretkey" : account.secretKey,
                            "error" : "NO"
                        ]
                        if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                            let str = String(data: data, encoding: .utf8) {
                            returnStr = str
                        }
                        self.responseBool = false
                    }
                }
                
            }
            
        }while self.responseBool
        
        
        
        
        return returnStr
    }
    
    @objc func getBalance(secretkey:String, status : String) -> String{
        var returnStr = ""
        self.loopstatus = true
        self.responseBool = true
        
        repeat
        {
            if(self.loopstatus)
            {
                
                let account = StellarSDK.Account.fromSecret(secretkey)  // Generates the public key secret key
                self.loopstatus = false
                if(account != nil)
                {
                    
                    if(status == "true")
                    {
                        account?.useNetwork(.live)
                        account?.usePublicNetwork()
                        let api = StellarSDK.Horizon.live  // .test for testing
                        api.loadAccount((account?.publicKey)!) { response in
                            if(response.error?.code == 404)
                            {
                               
                                let jsonObject: [String: Any] = [
                                    
                                    "balance" : "0",
                                    "error" : "This account is currently inactive. To activate it, send at least 1 lumen (XLM) to your Stellar public key"
                                ]
                                if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                                    let str = String(data: data, encoding: .utf8) {
                                    returnStr = str
                                }
                                self.responseBool = false
                            }
                            
                            else
                            {
                                account?.getBalances(callback: { response  in
                                    if(response.count <= 0)
                                    {
                                        let jsonObject: [String: Any] = [
                                            
                                            "balance" : "",
                                            "error" : "NetWork Failure"
                                        ]
                                        if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                                            let str = String(data: data, encoding: .utf8) {
                                            returnStr = str
                                        }
                                        self.responseBool = false
                                    }
                                    else
                                    {
                                        
                                        let jsonObject: [String: Any] = [
                                            
                                            "balance" : (response.first?.balance)!,
                                            "error" : "NO"
                                        ]
                                        if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                                            let str = String(data: data, encoding: .utf8) {
                                            returnStr = str
                                        }
                                        self.responseBool = false
                                    }
                                    
                                })
                            }
                            
                            
                        }
                    }
                    else
                    {
                        account?.useNetwork(.test)
                        account?.useTestNetwork()
                        account?.getBalances(callback: { response  in
                            if(response.count <= 0)
                            {
                                let jsonObject: [String: Any] = [
                                    
                                    "balance" : "",
                                    "error" : "NetWork Failure"
                                ]
                                if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                                    let str = String(data: data, encoding: .utf8) {
                                    returnStr = str
                                }
                                self.responseBool = false
                            }
                            else
                            {
                                
                                let jsonObject: [String: Any] = [
                                    
                                    "balance" : (response.first?.balance)!,
                                    "error" : "NO"
                                ]
                                if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                                    let str = String(data: data, encoding: .utf8) {
                                    returnStr = str
                                }
                                self.responseBool = false
                            }
                            
                        })
                    }
                    
                   
                }
                else
                {
                    let jsonObject: [String: Any] = [
                        
                        "balance" : "",
                        "error" : "Your Secret Key is wrong"
                    ]
                    if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                        let str = String(data: data, encoding: .utf8) {
                        returnStr = str
                    }
                    self.responseBool = false
                }
                
                
                
                
            }
            
        }while self.responseBool
        
        
        
        
        return returnStr
    }
    
    
    @objc func SendPayment(publickey:String,secretkey:String,amount:String,status:String) -> String{
        
        var returnStr = ""
        self.loopstatus = true
        self.responseBool = true
        repeat
        {
            
            if(self.loopstatus)
            {
                self.loopstatus = false
                let account = StellarSDK.Account.fromSecret(secretkey)  // Generates the public key secret key
                
                if(account != nil)
                {
                    if(status == "true")
                    {
                        account?.useNetwork(.live)
                        account?.usePublicNetwork()
                        let api = StellarSDK.Horizon.live  // .test for testing
                        api.loadAccount((account?.publicKey)!) { response in
                            if(response.error?.code == 404)
                            {
                                
                                let jsonObject: [String: Any] = [
                                    
                                    "balance" : "0",
                                    "error" : "This account is currently inactive. To activate it, send at least 1 lumen (XLM) to your Stellar public key"
                                ]
                                if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                                    let str = String(data: data, encoding: .utf8) {
                                    returnStr = str
                                }
                                self.responseBool = false
                            }
                                
                            else
                            {
                               
                                account?.getBalances(callback: { response  in
                                    
                                    if(response.count <= 0)
                                    {
                                        let jsonObject: [String: Any] = [
                                            
                                            "balance" : "",
                                            "error" : "NetWork Failure"
                                        ]
                                        if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                                            let str = String(data: data, encoding: .utf8) {
                                            returnStr = str
                                        }
                                        self.responseBool = false
                                    }
                                    else
                                    {
                                        
                                        if(((response.first?.balance)! as NSString).doubleValue >= (amount as NSString).doubleValue)
                                        {
                                            account?.payment(address: publickey, amount: (amount as NSString).doubleValue , memo:"yes", callback: { response in
                                                print(response.message)
                                                account?.getBalances(callback: { response  in
                                                    // print((response.first?.balance)!)
                                                    let jsonObject: [String: Any] = [
                                                        
                                                        "balance" : (response.first?.balance)!,
                                                        "error" : "NO"
                                                    ]
                                                    if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                                                        let str = String(data: data, encoding: .utf8) {
                                                        returnStr = str
                                                    }
                                                    self.responseBool = false
                                                })
                                            })
                                        }
                                        else
                                        {
                                            let jsonObject: [String: Any] = [
                                                
                                                "balance" : "",
                                                "error" : "Your balance is less than amount"
                                            ]
                                            if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                                                let str = String(data: data, encoding: .utf8) {
                                                returnStr = str
                                            }
                                            self.responseBool = false
                                        }
                                    }
                                    
                                    
                                })
                                
                                
                            }
                            
                            
                        }
                    }
                    else
                    {
                        account?.useNetwork(.test)
                        account?.useTestNetwork()
                        
                        
                        account?.getBalances(callback: { response  in
                            
                            if(response.count <= 0)
                            {
                                let jsonObject: [String: Any] = [
                                    
                                    "balance" : "",
                                    "error" : "NetWork Failure"
                                ]
                                if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                                    let str = String(data: data, encoding: .utf8) {
                                    returnStr = str
                                }
                                self.responseBool = false
                            }
                            else
                            {
                                
                                if(((response.first?.balance)! as NSString).doubleValue >= (amount as NSString).doubleValue)
                                {
                                    account?.payment(address: publickey, amount: (amount as NSString).doubleValue , memo:"yes", callback: { response in
                                        print(response.message)
                                        account?.getBalances(callback: { response  in
                                            // print((response.first?.balance)!)
                                            let jsonObject: [String: Any] = [
                                                
                                                "balance" : (response.first?.balance)!,
                                                "error" : "NO"
                                            ]
                                            if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                                                let str = String(data: data, encoding: .utf8) {
                                                returnStr = str
                                            }
                                            self.responseBool = false
                                        })
                                    })
                                }
                                else
                                {
                                    let jsonObject: [String: Any] = [
                                        
                                        "balance" : "",
                                        "error" : "Your balance is less than amount"
                                    ]
                                    if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                                        let str = String(data: data, encoding: .utf8) {
                                        returnStr = str
                                    }
                                    self.responseBool = false
                                }
                            }
                            
                            
                        })
                        
                    }
                    
                   
                }
                else
                {
                    let jsonObject: [String: Any] = [
                        
                        "balance" : "",
                        "error" : "Your Secret Key is wrong"
                    ]
                    if let data = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted),
                        let str = String(data: data, encoding: .utf8) {
                        returnStr = str
                    }
                    self.responseBool = false
                }
                
                
                //loopstatus
            }
            
        }while self.responseBool
        
        
        return returnStr
        
    }
    
    
}


