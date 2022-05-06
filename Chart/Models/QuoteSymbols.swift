//
//  QuoteSymbols.swift
//  Chart
//
//  Created by Sergey on 06.05.2022.
//

import Foundation
import Charts

struct FileContent: Codable {
    let content: QuoteSymbols
    let status: String
}

struct QuoteSymbols: Codable {
    let quoteSymbols: [QuoteSymbol]
}

struct QuoteSymbol: Codable {
    let symbol: String
    let timestamps: [Int]
    let opens: [Double]
    let closures: [Double]
    let highs: [Double]
    let lows: [Double]
    let volumes: [Int]
}
