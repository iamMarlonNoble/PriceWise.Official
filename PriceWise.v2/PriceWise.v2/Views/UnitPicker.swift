//
//  UnitPicker.swift
//  PriceWise.v2
//
//  Created by Marlon Noble on 12/5/23.
//

import Foundation
import UIKit

protocol UnitPickerDelegate: AnyObject {
    func didSelectUnit(_ unit: String?)
}

class UnitPickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    let units = ["mg", "g", "kg"]
    var selectedUnit: String?
    weak var unitDelegate: UnitPickerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIPickerViewDataSource
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return units.count
    }
    
    // MARK: - UIPickerViewDelegate
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return units[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedUnit = units[row]
        unitDelegate?.didSelectUnit(selectedUnit)
    }
}
