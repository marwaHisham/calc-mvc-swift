//
//  calc_Brain.swift
//  mvc_calc
//
//  Created by mino on 4/15/18.
//  Copyright © 2018 marwa. All rights reserved.
//

import Foundation

struct calc_Brain {
    
    var delegate: CalculatorBrainDelegate?
    
    enum Operation {
        case constant(Double)
        case unaryOperation( (Double) -> Double )
        case binaryOperaton( (Double, Double) -> Double )
        case equal
    }
    
    struct PendingOperation {
        var operation: Operation
        var operand: Double
    }
    
    var mathOperations = [
        "π" : Operation.constant(Double.pi),
        "√" : Operation.unaryOperation({ sqrt($0) }),
        "+" : Operation.binaryOperaton({ $0 + $1 }),
        "-" : Operation.binaryOperaton({ $0 - $1 }),
        "*" : Operation.binaryOperaton({ $0 * $1 }),
        "/" : Operation.binaryOperaton({ $0 / $1 }),
        "=" : Operation.equal,
        "cos":Operation.unaryOperation(cos),
        "e":Operation.constant(M_E),
        "±":Operation.unaryOperation({ -$0 })
        
        ]
    
    var pbo: PendingOperation?
    
    var accumulator: Double? {
        didSet {
            self.delegate?.accumulatorDidChange(self.accumulator!)
        }
    }
    
    mutating func performOperation(_ operation: String) {
        //        let sqrtOp = Operation.unaryOperation { sqrt($0) }
        
        if let op = mathOperations[operation] {
            switch op {
            case .constant(let x):
                self.accumulator = x
                
            case .unaryOperation(let function):
                self.accumulator = function(self.accumulator!)
                
            case .binaryOperaton(let function):
                self.pbo = PendingOperation(operation: .binaryOperaton(function),
                                            operand: self.accumulator!)
            case .equal:
                switch pbo!.operation {
                case .binaryOperaton(let function):
                    self.accumulator = function(self.pbo!.operand, self.accumulator!)
                default:
                    break
                }
            }
        }
        }
    
    var result: Double  {
        if accumulator != nil {
            return self.accumulator!
        }
        return 0
    }
}

protocol CalculatorBrainDelegate {
    func accumulatorDidChange(_ newValue: Double)
}

