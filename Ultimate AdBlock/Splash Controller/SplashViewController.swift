//
// THIS APPLICATION WAS DEVELOPED BY IURII DOLOTOV
//
// IF YOU HAVE ANY QUESTIONS PLEASE DO NOT TO HESITATE TO CONTACT ME VIA MARKETPLACE OR EMAIL: utilityman.development@gmail.com
//
// THE AUTHOR REMAINS ALL RIGHTS TO THE PROJECT
//
// THE ILLEGAL DISTRIBUTION IS PROHIBITED
//

import UIKit
import Purchases
import SafariServices

class SplashViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        Purchases.shared.purchaserInfo { (purchaserInfo, error) in
            if let e = error {
                print(e.localizedDescription)
            }
            
            if purchaserInfo?.entitlements["fullappaccess"]?.isActive == true {
                self.performSegue(withIdentifier: "user_subscribed", sender: self)
                let save = UserDefaults(suiteName: "group.ad.block")
                save!.set(true, forKey: "user_is_subscribed")
                save!.synchronize()
                
                SFContentBlockerManager.reloadContentBlocker(withIdentifier: "com.utilitymandevelopment.adblock.ContentBlock", completionHandler: { error in
                    print(error as Any)
                })
            } else {
                self.performSegue(withIdentifier: "user_not_subscribed", sender: self)
                let save = UserDefaults(suiteName: "group.ad.block")
                save!.set(nil, forKey: "user_is_subscribed")
                save!.synchronize()
                
                SFContentBlockerManager.reloadContentBlocker(withIdentifier: "com.utilitymandevelopment.adblock.ContentBlock", completionHandler: { error in
                    print(error as Any)
                })
            }
        }
    }
        
}
