//
// NoobAuthenticationManager.swift
// Cityflo
//
// Created by Abhishek Agarwal on 08/10/23.
// Copyright © Cityflo. All rights reserved.
//


import Foundation

class NoobAuthenticationManager: NSObject, URLAuthenticationChallengeSender {
    
    typealias NooberAuthenticationManager = (URLSession.AuthChallengeDisposition, URLCredential?) -> Void
    
    let handler: NooberAuthenticationManager
    
    init(handler: @escaping NooberAuthenticationManager) {
        self.handler = handler
        super.init()
    }
    
    func use(_ credential: URLCredential, for challenge: URLAuthenticationChallenge) {
        handler(.useCredential, credential)
    }
    
    func continueWithoutCredential(for challenge: URLAuthenticationChallenge) {
        handler(.useCredential, nil)
    }
    
    func cancel(_ challenge: URLAuthenticationChallenge) {
        handler(.cancelAuthenticationChallenge, nil)
    }
    
    func performDefaultHandling(for challenge: URLAuthenticationChallenge) {
        handler(.performDefaultHandling, nil)
    }
    
    func rejectProtectionSpaceAndContinue(with challenge: URLAuthenticationChallenge) {
        handler(.rejectProtectionSpace, nil)
    }
}
