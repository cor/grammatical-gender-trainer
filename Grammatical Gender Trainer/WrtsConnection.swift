//
//  WrtsClient.swift
//  Grammatical Gender Trainer
//
//  Created by Jurriaan Pruijs on 03-02-15.
//  Copyright (c) 2015 Jurriaan Pruijs. All rights reserved.
//

import Foundation

class WrtsConnection : NSObject, Printable, NSURLConnectionDataDelegate
{
    let username : String    // wrts@pruijs.nl
    let password : String    // uBq-eS8-nKs-d8p
    
    var name: String { return "Wrts - \(username)" }

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    func read(url: String) -> NSData {
        // println("read  \(url)")
        
        // set up the base64-encoded credentials
        let loginString = NSString(format: "%@:%@", username, password)
        let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
        let base64LoginString = loginData.base64EncodedStringWithOptions(nil)
        
        // create the request
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        request.HTTPMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        
        // fire off the request
        // make sure your class conforms to NSURLConnectionDelegate
        let urlConnection = NSURLConnection(request: request, delegate: self)
        
        
        var response: AutoreleasingUnsafeMutablePointer<NSURLResponse?>=nil
        var error: NSErrorPointer = nil
        var dataVal: NSData =  NSURLConnection.sendSynchronousRequest(request, returningResponse: response, error:nil)!
        var err: NSError

        // println(NSString(data:dataVal, encoding:NSUTF8StringEncoding))
        
        return dataVal
    }
    
    func parse(connection: WrtsConnection, url: String, delegate: NSXMLParserDelegate) {
        var xmlParser = NSXMLParser(data: read(url))
        xmlParser.delegate = delegate
        xmlParser.parse()
    }

    
    override var description : String {
        return "Wrts connection for \(username)"
    }
    

}