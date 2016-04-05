//
//  NetworkHandler.swift
//  Beer30
//
//  Created by Clinton Medbery on 4/2/16.
//  Copyright © 2016 Programadores Sans Frontieres. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

class NetworkHandler {
    static let handler = NetworkHandler()
    var manager: Manager?

//    init(){
//        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
//        configuration.HTTPAdditionalHeaders = Alamofire.Manager.defaultHTTPHeaders
//        let serverTrustPolicies: [String: ServerTrustPolicy] = [
//            "sparcedge.com": .DisableEvaluation
//        ]
//        
////        manager = Alamofire.Manager(configuration: configuration, serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies))
//
//    }
//    
    func readyManager(completion: ((success:Bool, result: JSON) -> Void)!) {
        
        
        var defaultHeaders = Alamofire.Manager.sharedInstance.session.configuration.HTTPAdditionalHeaders ?? [:]
        defaultHeaders["X-Auth-Module"] = "1"
        
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "sparcedge.com": .DisableEvaluation
        ]
        // Create custom manager
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        configuration.HTTPAdditionalHeaders = defaultHeaders
        manager = Alamofire.Manager(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        readyCredentials(manager!)
                manager!.request(.GET, "https://beer30v2.sparcedge.com/beer30.json").responseJSON { response in
//                    print(response.request)  // original URL request
//                    print(response.response) // URL response
//                    print(response.data)     // server data
//                    print(response.result)   // result of response serialization
//                    print(response)
//                    var responseJSON: String = response.result.value as! String
                    if response.result.isSuccess {
                        let json:JSON = JSON(response.result.value!)
                        completion(success: true, result: json)
                    } else {
                        completion(success:false, result: nil)
                    }
                    
                }
            }
    
    }

    
    func readyCredentials(manager: Manager){
        manager.delegate.sessionDidReceiveChallenge = { session, challenge in
            var disposition: NSURLSessionAuthChallengeDisposition = .PerformDefaultHandling
            var credential: NSURLCredential?
            
            if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
                disposition = NSURLSessionAuthChallengeDisposition.UseCredential
                credential = NSURLCredential(forTrust: challenge.protectionSpace.serverTrust!)
            } else {
                if challenge.previousFailureCount > 0 {
                    disposition = .CancelAuthenticationChallenge
                } else {
                    credential = manager.session.configuration.URLCredentialStorage?.defaultCredentialForProtectionSpace(challenge.protectionSpace)
                    
                    if credential != nil {
                        disposition = .UseCredential
                    }
                }
            }
            
            return (disposition, credential)
    }

    


}



