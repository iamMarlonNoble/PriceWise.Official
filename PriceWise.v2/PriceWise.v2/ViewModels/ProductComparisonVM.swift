//
//  ProductComparisonVM.swift
//  PriceWise.v2
//
//  Created by Marlon Noble on 12/5/23.
//

import Foundation

class ProductComparisonVM {
    var product1: Product
    var product2: Product
    var unit: [String] = ["Length", "Weight", "Volume"]
    var unitPrices: [Double] = []
    var prices: [Double] = []
    var quantities: [Double] = []
    var filteredUnitPrices: [Double] = []
    let itemNumbers = [1, 2]
    var willSave = 0.0
    var betterDeal = 0
    var missingValue = false
    
    init(product1: Product, product2: Product) {
        self.product1 = product1
        self.product2 = product2
    }
    
    func itemChecker() -> Bool {
        let arrayOfQuantities = [product1.quantity, product2.quantity]
        let arrayOfPrices = [product1.price, product2.price]
        
        for (quantity, price) in zip(arrayOfQuantities, arrayOfPrices) {
            let itemQuantity = Double(quantity ) ?? 0
            let itemPrice = Double(price ) ?? 0
            
            if quantity.isEmpty == false && price.isEmpty == false {
                let unitPrice = Double(itemPrice / itemQuantity).rounded(toPlaces: 20)
                unitPrices.append(unitPrice)
                prices.append(itemPrice)
                quantities.append(itemQuantity)
            } else if quantity.isEmpty && price.isEmpty {
//                unitPrices.append(0.0)
                missingValue = true
            } else if quantity.isEmpty == false && price.isEmpty {
                missingValue = true
            } else if quantity.isEmpty && price.isEmpty == false {
                missingValue = true
            }
        }
        
        if unitPrices.count != 2 {
            print("\nPlease check your itemsss!!\n\n\n\n* * * E.N.D * * *")
            return missingValue
        } else {
            print("\nPerforming calculations....")
            return false
        }
    }
    
    func checkUnits() -> Bool {
        prices.removeAll()
        quantities.removeAll()
        unitPrices.removeAll()
        filteredUnitPrices.removeAll()
        if product1.unitOfMeasurement == product2.unitOfMeasurement {
            print(product1.unitOfMeasurement)
            print(product2.unitOfMeasurement)
            print("Units for each products are the same")
            return true
        } else {
            print(product1.unitOfMeasurement)
            print(product2.unitOfMeasurement)
            print("Units for each products are NOT the same")
            let unit = product2.unitOfMeasurement
            let value1 = Double(product1.quantity) ?? 0
            let value2 = Double(product2.quantity) ?? 0
            convertUnits(unit: product1.unitOfMeasurement, unit2: product2.unitOfMeasurement, value: value2)
            if product1.unitOfMeasurement == product2.unitOfMeasurement {
                print(product1.unitOfMeasurement)
                print(product2.unitOfMeasurement)
                print("Units for each products are the same")
                return true
            } else {
                return false
            }
        }
    }
    
    func convertUnits(unit: String, unit2: String, value: Double) {
        print("Converting Units.....")
        let weight = ""
        let result: Measurement<UnitMass>
        var result2 = Measurement(value: 0, unit: UnitMass.grams)
        if unit == "kg" {
//            result = Measurement(value: value, unit: UnitMass.kilograms)
            if unit2 == "g" {
                result = Measurement(value: value, unit: UnitMass.grams)
                result2 = result.converted(to: UnitMass.kilograms)
            } else {
                result = Measurement(value: value, unit: UnitMass.milligrams)
                result2 = result.converted(to: UnitMass.kilograms)
            }
            print(result2)
        } else if unit == "g" {
//            result = Measurement(value: value, unit: UnitMass.grams)
            if unit2 == "kg" {
                result = Measurement(value: value, unit: UnitMass.kilograms)
                result2 = result.converted(to: UnitMass.grams)
            } else {
                result = Measurement(value: value, unit: UnitMass.milligrams)
                result2 = result.converted(to: UnitMass.grams)
            }
            print(result2)
        } else if unit == "mg" {
            if unit2 == "g" {
                result = Measurement(value: value, unit: UnitMass.grams)
                result2 = result.converted(to: UnitMass.milligrams)
            } else {
                result = Measurement(value: value, unit: UnitMass.kilograms)
                result2 = result.converted(to: UnitMass.milligrams)
            }
            print(result2)
        }
        
        let product2Unit = result2.unit.symbol
        let product2Quantity = String(result2.value)
        product2.quantity = product2Quantity
        product2.unitOfMeasurement = product2Unit
    }
    
    func calculateAmountWillSave() -> String {
        let highestQuantity = Double(quantities.max() ?? 0)
        let lowestQuantity = Double(quantities.min() ?? 0)
        let highestPrice = Double(prices.max() ?? 0)
        let lowestPrice = Double(prices.min() ?? 0)
        
        let quotient = highestQuantity / lowestQuantity
        let product = quotient * lowestPrice
        var difference = 0.00
        if product > highestPrice {
            difference = Double(product - highestPrice).rounded(toPlaces: 2)
        } else {
            difference = Double(highestPrice - product).rounded(toPlaces: 2)
        }
        willSave = difference
        return "You will save: \(willSave)\n\n\n\n* * * E.N.D * * *"
    }
    
    func calculateBetterDeal() -> String {
        for unitPrice in unitPrices {
            if unitPrice != 0.0 {
                filteredUnitPrices.append(unitPrice)
            }
        }
        let lowestUnitPrice = filteredUnitPrices.min() ?? 0
        let indexOfLowestUP = unitPrices.firstIndex(of: lowestUnitPrice) ?? 0
        let itemNumber = itemNumbers[indexOfLowestUP]
        if willSave != 0.0 {
            return "Product \(itemNumber) is the better deal."
        } else {
            return "Both products are equally priced."
        }
    }
    
    func updateUnit(for product: inout Product, with unitOfMeasurement: String) {
        product.unitOfMeasurement = unitOfMeasurement
    }
}
