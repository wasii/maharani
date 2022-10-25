//
//  ThankYouCartVC.swift
//  Opium
//
//  Created by Zain on 16/12/2021.
//

import UIKit

class ThankYouCartVC: UIViewController {
    var orderNo  = ""
    @IBOutlet weak var btnOrderId: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnOrderId.setTitle(orderNo, for:.normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            Switcher.gotoTabbar()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = true
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        
    }
    @IBAction func gotoBookings(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
       // delegate?.goBack()
        Switcher.gotoTabbar()
        
    }

}
