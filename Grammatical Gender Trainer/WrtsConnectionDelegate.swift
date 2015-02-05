//
//  WrtsConnectionDelegate.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 05-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class WrtsConnectionDelegate : NSObject, NSURLConnectionDataDelegate
{
    let delegate: NSXMLParserDelegate
    let semaphore: dispatch_semaphore_t
    let data = NSMutableData()
    let username: String
    let password: String
    let protectionHost: String
    
    init(username: String, password: String, protectionHost: String, delegate: NSXMLParserDelegate, semaphore: dispatch_semaphore_t) {
        self.username = username
        self.password = password
        self.protectionHost = protectionHost
        
        self.delegate = delegate
        self.semaphore = semaphore
    }
    
    func connection(connection: NSURLConnection, canAuthenticateAgainstProtectionSpace protectionSpace: NSURLProtectionSpace) -> Bool {

        return protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust ||
            protectionSpace.authenticationMethod == NSURLAuthenticationMethodHTTPBasic

    }
    
    func connection(connection: NSURLConnection, didReceiveAuthenticationChallenge challenge: NSURLAuthenticationChallenge) {
        let protectionSpace = challenge.protectionSpace
        let host = protectionSpace.host

        if host == protectionHost {
            let authenticationMethod = protectionSpace.authenticationMethod
            
            if authenticationMethod == NSURLAuthenticationMethodServerTrust {
                let credentials = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust)
                challenge.sender.useCredential(credentials, forAuthenticationChallenge: challenge)
            } else if authenticationMethod == NSURLAuthenticationMethodHTTPBasic {
                let credentials = NSURLCredential(user: username, password: password, persistence: NSURLCredentialPersistence.ForSession)
                challenge.sender.useCredential(credentials, forAuthenticationChallenge: challenge)
            } else {
                println("unknown")
            }
        } else {
            challenge.sender.continueWithoutCredentialForAuthenticationChallenge(challenge)
        }
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData!) {
        self.data.appendData(data)
    }
    
    func connectionDidFinishLoading(connection: NSURLConnection!)
    {
        let text = NSString(data: data, encoding: NSUTF8StringEncoding)!
        
        var xmlParser = NSXMLParser(data: data)
        xmlParser.delegate = delegate
        xmlParser.parse()
        
        dispatch_semaphore_signal(semaphore)
    }
}