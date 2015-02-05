//
//  WrtsClient.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 03-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class WrtsConnection : NSObject, Printable
{
    let username: String    // wrts@pruijs.nl
    let password: String    // uBq-eS8-nKs-d8p
    let protectionHost: String // "www.wrts.nl"
    
    var name: String { return "Wrts - \(username)" }

    init(username: String, password: String, protectionHost: String) {
        self.username = username
        self.password = password
        self.protectionHost = protectionHost
    }
    
    func read(url: String, delegate: NSURLConnectionDataDelegate) {
        dispatch_async(dispatch_get_main_queue()) {
            
            // create the request
            
            var data = NSMutableData()
            var url1: NSURL = NSURL(string: url)!
            var request: NSURLRequest = NSURLRequest(URL: url1)
            var connection: NSURLConnection = NSURLConnection(request: request, delegate: delegate, startImmediately: true)!
            connection.start()
        }
    }
    
    
    func parse(connection: WrtsConnection, url: String, delegate: NSXMLParserDelegate) {
        
        var semaphore = dispatch_semaphore_create(0)
        
        self.read(url, delegate: WrtsConnectionDelegate(username: username, password: password, protectionHost: protectionHost, delegate: delegate, semaphore: semaphore))
        
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
    }
    
   
    override var description : String {
        return "Wrts connection for \(username)"
    }
    

}