import Foundation
import UIKit
import SwiftUI

final class NoobHelper {
    
    static let shared = NoobHelper()
    
    private(set) var hasStarted = false
    private var isNoobVisible = false
    private var topViewController: UIViewController? {
        var rootViewController = UIApplication.shared.keyWindow?.rootViewController
        while let controller = rootViewController?.presentedViewController {
            rootViewController = controller
        }
        return rootViewController
    }
    
    private let vm = NoobViewModel()
    
    private lazy var noobController: UIViewController  =  {
        let vc = UIHostingController(rootView: HomeView(viewModel: vm))
        vc.modalPresentationStyle = .overFullScreen
        return vc
    }()
    
    func toggle() {
        guard hasStarted else {fatalError("Noober is not started yet.")}
        if isNoobVisible {
            noobController.dismiss(animated: true)
        } else {
            topViewController?.present(noobController, animated: true)
        }
        isNoobVisible.toggle()
        Haptic.toggleFeedback()
    }
    
    func startNoober() {
        guard !hasStarted else {return}
        hasStarted = true
        URLSessionConfiguration.implementNoober()
    }
    
    func stopNoober() {
        guard hasStarted else {return}
        hasStarted = false
    }
    
    func share(_ link: String) {
        let activityViewController = UIActivityViewController(activityItems: [link], applicationActivities: nil)
        topViewController?.present(activityViewController, animated: true, completion: nil)
    }
    
    func openNoobGithubRepository() {
        UIApplication.shared.open(URL(string: "https://github.com/ABHI165/Noober-iOS")!)
    }
}


//MARK: - URLSessionConfiguration
@objc extension URLSessionConfiguration {
    private static var firstOccurrence = true
    
    static func implementNoober() {
        guard firstOccurrence else { return }
        URLProtocol.registerClass(NoobProtocol.self)
        firstOccurrence = false
        swizzleProtocolSetter()
        swizzleDefault()
        swizzleEphemeral()
    }
    
    private static func swizzleProtocolSetter() {
        let instance = URLSessionConfiguration.default
        
        let aClass: AnyClass = object_getClass(instance)!
        
        let origSelector = #selector(setter: URLSessionConfiguration.protocolClasses)
        let newSelector = #selector(setter: URLSessionConfiguration.protocolClasses_Swizzled)
        
        let origMethod = class_getInstanceMethod(aClass, origSelector)!
        let newMethod = class_getInstanceMethod(aClass, newSelector)!
        
        method_exchangeImplementations(origMethod, newMethod)
    }
    
    @objc private var protocolClasses_Swizzled: [AnyClass]? {
        get {
            // Unused, but required for compiler
            return self.protocolClasses_Swizzled
        }
        set {
            guard let newTypes = newValue else { self.protocolClasses_Swizzled = nil; return }
            
            var types = [AnyClass]()
            
            // de-dup
            for newType in newTypes {
                if !types.contains(where: { $0 == newType }) {
                    types.append(newType)
                }
            }
            
            self.protocolClasses_Swizzled = types
        }
    }
    
    private static func swizzleDefault() {
        let aClass: AnyClass = object_getClass(self)!
        
        let origSelector = #selector(getter: URLSessionConfiguration.default)
        let newSelector = #selector(getter: URLSessionConfiguration.default_swizzled)
        
        let origMethod = class_getClassMethod(aClass, origSelector)!
        let newMethod = class_getClassMethod(aClass, newSelector)!
        
        method_exchangeImplementations(origMethod, newMethod)
    }
    
    private static func swizzleEphemeral() {
        let aClass: AnyClass = object_getClass(self)!
        
        let origSelector = #selector(getter: URLSessionConfiguration.ephemeral)
        let newSelector = #selector(getter: URLSessionConfiguration.ephemeral_swizzled)
        
        let origMethod = class_getClassMethod(aClass, origSelector)!
        let newMethod = class_getClassMethod(aClass, newSelector)!
        
        method_exchangeImplementations(origMethod, newMethod)
    }
    
    @objc private class var default_swizzled: URLSessionConfiguration {
        get {
            let config = URLSessionConfiguration.default_swizzled
            config.protocolClasses?.insert(NoobProtocol.self, at: 0)
            return config
        }
    }
    
    @objc private class var ephemeral_swizzled: URLSessionConfiguration {
        get {
            let config = URLSessionConfiguration.ephemeral_swizzled
            config.protocolClasses?.insert(NoobProtocol.self, at: 0)
            return config
        }
    }
}
