//
//  AppAlert + UIVIewController.swift
//  Pricerite eShop
//
//  Created by Yagnik.Dharaiya on 14/02/21.
//

import UIKit

extension UIViewController {
    
    var topViewController : UIViewController {
        self.tabBarController ?? self
    }
    
    //MARK: KEY WINDOW
    static var keyWindow:UIWindow? {
        if #available(iOS 13, *) {
            return UIApplication.shared.connectedScenes
                .filter({$0.activationState == .foregroundActive})
                .map({$0 as? UIWindowScene})
                .compactMap({$0})
                .first?.windows
                .filter({$0.isKeyWindow}).first
        }else{
            return UIApplication.shared.keyWindow
        }
    }
    
    
    func showAppAlert(title:String,message : String,style : UIAlertController.Style,actions : [UIAlertAction], completion: (() -> Void)?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        for alertAction in actions {
            alertController.addAction(alertAction)
        }
        DispatchQueue.main.async {
            self.topViewController.present(alertController, animated: false, completion: {
                guard let comp = completion else { return }
                comp()
            })
        }
    }
    
    func showAppAlertWithOK(title:String = "Alert" ,message : String,
                         buttonTitle : String = "OK",
                         buttonAction :( ()->Void )?,
                         cancelAlertOnClick : Bool = true,
                         style: UIAlertController.Style,
                         buttonStyle : UIAlertAction.Style = .default, completion: ( ()->Void )?){
        
        let action = UIAlertAction(title: buttonTitle, style: buttonStyle) { _ in
            guard let action = buttonAction else {return}
            action()
        }
        self.showAppAlert(title: title, message: message,style: style, actions: [action], completion: completion)
    }
    
    func showAppAlertWithOkAndCancel(title:String = "Alert",message : String,
                                     okButtonTitle : String = "OK",
                                     okButtonAction :( ()->Void )?,
                                     cancelAlertOnOKClick : Bool = true,
                                     cancelButtonTitle : String = "Cancel",
                                     cancelButtonAction :( ()->Void )?,
                                     style: UIAlertController.Style, completion: ( ()->Void )? ){
        let okAction = UIAlertAction(title: okButtonTitle, style: .default) { _ in
            guard let action = okButtonAction else {return}
            action()
        }
        let cancelAction = UIAlertAction(title: cancelButtonTitle, style: .destructive) { _ in
            guard let action = cancelButtonAction else {return}
            action()
        }

        self.showAppAlert(title: title, message: message, style: style, actions: [okAction,cancelAction], completion: completion)
    }
}


//MARK:-Find TopMost VC To Present Alert
extension UIApplication {
    
    class func topViewController(controller: UIViewController? = UIViewController.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}
