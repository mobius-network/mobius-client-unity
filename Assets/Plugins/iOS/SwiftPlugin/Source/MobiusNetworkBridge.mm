#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#include "Mobius_Uinty_iOS_Plugin-Swift.h"



#pragma mark - C interface
extern "C" {
    char* _sayHiToUnity() {
        
        NSString *returnString = [[MobiusNetwork shared]       SayHiToUnity];
        char* cStringCopy(const char* string);
        return cStringCopy([returnString UTF8String]);
        
    }
    
    void _NativeMethodName(const char* stringValue)
    {
        NSString *input = [[NSString alloc] initWithUTF8String:stringValue];// convert
        NSLog(@"Passed nSstring value: %@", input);
    }
    
    
    char* _CreateAccount(const char* status) {
        
        NSString *statusStr = @(status);
        NSString *returnString = [[MobiusNetwork shared]       CreateAccountWithStatus:statusStr];
        char* cStringCopy(const char* string);
        return cStringCopy([returnString UTF8String]);
    }
    
    
    char* _getBalance(char* secretkey, const char* status) {
        NSString *secretkeyStr = @(secretkey);
        NSString *statusStr = @(status);
        NSString *returnString = [[MobiusNetwork shared]       getBalanceWithSecretkey:secretkeyStr status:statusStr];
        char* cStringCopy(const char* string);
        return cStringCopy([returnString UTF8String]);
    }
    
    char* _SendPayment(const char* publickey,const char* secretkey,const char* amount,const char* status) {
        NSString *publickeyStr = @(publickey);//[[NSString alloc] initWithUTF8String:publickey];
        NSString *secretkeyStr = @(secretkey);
        NSString *amountStr = @(amount);
        NSString *statusStr = @(status);
        NSString *returnString = [[MobiusNetwork shared]       SendPaymentWithPublickey:publickeyStr secretkey:secretkeyStr amount:amountStr status:statusStr];
        char* cStringCopy(const char* string);
        return cStringCopy([returnString UTF8String]);
    }
}




char* cStringCopy(const char* string){
    if (string == NULL){
        return NULL;
    }
    char* res = (char*)malloc(strlen(string)+1);
    strcpy(res, string);
    return res;
}
