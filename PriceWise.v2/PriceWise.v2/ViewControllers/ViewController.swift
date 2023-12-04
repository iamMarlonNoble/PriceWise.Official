//
//  PriceWiseVC.swift
//  PriceWise.v2
//
//  Created by Marlon Noble on 12/4/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemRed
        pushVC()
    }
    
    func pushVC() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let priceWiseVCStoryboard = UIStoryboard(name: "PriceWise", bundle: nil)
            let priceWiseVC = priceWiseVCStoryboard.instantiateViewController(withIdentifier: "PriceWiseVC") as! PriceWiseVC
            self.navigationController?.pushViewController(priceWiseVC, animated: true)
            print("vc pushed")
        }
    }

}
