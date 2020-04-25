//
//  main.swift
//  Adapter
//
//  Created by Никита Строков on 25.04.2020.
//  Copyright © 2020 Никита Строков. All rights reserved.
//

protocol BMRImperialCalculation {
    func bmr(height: Double, weight: Double, age: Int) -> Int
}

struct BMRCalculator: BMRImperialCalculation {
    func bmr(height: Double, weight: Double, age: Int) -> Int {
        return Int(66 + (6.2 * weight) + (12.7 * height) - (6.76 * Double(age)))
    }
}

protocol BMRMetricCalculator {
    func metricBMR(height: Double, weight: Double, age: Int) -> String
}

struct BMRCalculatorAdapter: BMRMetricCalculator {
    private var adaptee: BMRImperialCalculation
    init(adaptee: BMRImperialCalculation) {
        self.adaptee = adaptee
    }
    
    func metricBMR(height: Double, weight: Double, age: Int) -> String {
        let iHeight = height * 3.28084
        let iWeight = weight * 2.20462
        let result = adaptee.bmr(height: iHeight, weight: iWeight, age: age)
        return "BMR is \(result). \(result > 1000 ? "Hight." : "Low.")"
    }
}

struct Person {
    func checkBMR(calculator: BMRMetricCalculator) {
        print(calculator.metricBMR(height: 1.84, weight: 74, age: 26))
    }
}

let person = Person()
person.checkBMR(calculator: BMRCalculatorAdapter(adaptee: BMRCalculator()))
