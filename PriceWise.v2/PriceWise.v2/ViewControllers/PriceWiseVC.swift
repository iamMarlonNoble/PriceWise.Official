//
//  PriceWiseVC.swift
//  PriceWise.v2
//
//  Created by Marlon Noble on 12/4/23.
//

import UIKit

class PriceWiseVC: UIViewController, UIPopoverPresentationControllerDelegate, UnitPickerDelegate {
    
    @IBOutlet weak var quantity1TF: UITextField!
    @IBOutlet weak var price1TF: UITextField!
    @IBOutlet weak var quantity2TF: UITextField!
    @IBOutlet weak var price2TF: UITextField!
    @IBOutlet weak var product1UnitButton: UIButton!
    @IBOutlet weak var product2UnitButton: UIButton!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var saveLabel: UILabel!
    
    var viewModel: ProductComparisonVM!
    
    var unitPickerView: UnitPickerView?
    var selectedProductIndex: Int = 0
    
    var unit1 = ""
    var unit2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let product1 = Product(id: "", itemName: "", price: "", quantity: "", unitOfMeasurement: "")
        let product2 = Product(id: "", itemName: "", price: "", quantity: "", unitOfMeasurement: "")
        
        viewModel = ProductComparisonVM(product1: product1, product2: product2)
        unitPickerView = UnitPickerView()
        unitPickerView?.unitDelegate = self
        
        self.navigationItem.hidesBackButton = true
        setNeedsStatusBarAppearanceUpdate()
        //        setupUnitPicker()
    }
    
    func didTapButton() {
        viewModel.product1.price = price1TF.text ?? ""
        viewModel.product1.quantity = quantity1TF.text ?? ""
        viewModel.product1.unitOfMeasurement = unit1
        viewModel.product2.price = price2TF.text ?? ""
        viewModel.product2.quantity = quantity2TF.text ?? ""
        viewModel.product2.unitOfMeasurement = unit2
        
        let unitsChecker = viewModel.checkUnits()
        if unitsChecker == true {
            let fieldChecker = viewModel.itemChecker()
            if viewModel.prices.count != 0 || viewModel.quantities.count != 0 {
                if fieldChecker == false {
                    let willSave = viewModel.calculateAmountWillSave()
                    let betterDeal = viewModel.calculateBetterDeal()
                    resultLabel.text = "\(betterDeal)"
                    saveLabel.text = "\(willSave)"
                    print(betterDeal)
                    print(willSave)
                } else {
                    //            print("Please check your itemsss!!!")
                }
                
            } else {
                resultLabel.text = "Please check your items!"
                saveLabel.text = ""
            }
        } else {
            //            print("Please check your itemsss!!!")
        }
    }

    
    @IBAction func testBtn(_ sender: Any) {
        didTapButton()
    }
    @IBAction func unit1btnTapped(_ sender: UIButton) {
        selectedProductIndex = 0
        presentUnitPicker()
    }
    @IBAction func unit2btnTapped(_ sender: UIButton) {
        selectedProductIndex = 1
        presentUnitPicker()
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    func didSelectUnit(_ unit: String?) {
        guard let selectedUnit = unit else {
            return // Handle the case where no unit is selected
        }
        
        if selectedProductIndex == 0 {
            product1UnitButton.setTitle(selectedUnit, for: .normal)
            unit1 = selectedUnit
            // Perform further actions based on the selected unit for product 1
        } else {
            product2UnitButton.setTitle(selectedUnit, for: .normal)
            unit2 = selectedUnit
            // Perform further actions based on the selected unit for product 2
        }
        
        // You can perform any necessary logic based on the selected unit here
        dismiss(animated: true, completion: nil) // Dismiss the popover after selecting the unit
    }

    private func presentUnitPicker() {
        // Show the unit picker when the button is tapped
        guard let unitPickerView = unitPickerView else { return }
        
        let popoverContentController = UIViewController()
        popoverContentController.view = unitPickerView
        
        popoverContentController.modalPresentationStyle = .popover
        popoverContentController.preferredContentSize = CGSize(width: 200, height: 200) // Set preferred content size
        
        let popoverPresentationController = popoverContentController.popoverPresentationController
        popoverPresentationController?.permittedArrowDirections = .any
        if selectedProductIndex == 0 {
            popoverPresentationController?.sourceView = product1UnitButton
            popoverPresentationController?.sourceRect = product1UnitButton.bounds
        } else {
            popoverPresentationController?.sourceView = product2UnitButton
            popoverPresentationController?.sourceRect = product2UnitButton.bounds
        }
        popoverPresentationController?.delegate = self
        
        present(popoverContentController, animated: true, completion: nil)
    }
    @IBAction func didTapSearchItem(_ sender: UIButton) {
        let masterListVCStoryboard = UIStoryboard(name: "MasterList", bundle: nil)
        let pmasterListVC = masterListVCStoryboard.instantiateViewController(withIdentifier: "masterList") as! MasterListVC
        self.navigationController?.pushViewController(pmasterListVC, animated: true)
        print("vc pushed")
    }
}
