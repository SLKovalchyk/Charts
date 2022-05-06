//
//  ChartDataWorker.swift
//  Chart
//
//  Created by Sergey on 06.05.2022.
//

import Foundation
import Charts
import UIKit

public enum DatePeriod: String {
    case month
    case week
    
    var fileName: String {
        switch self {
        case .month: return "responseQuotesMonth"
        case .week: return "responseQuotesWeek"
        }
    }
}

final class ChartDataWorker {
    var monthData: QuoteSymbols = QuoteSymbols(quoteSymbols: [])
    var weekData: QuoteSymbols = QuoteSymbols(quoteSymbols: [])
    
    static let shared: ChartDataWorker = {
        let instance = ChartDataWorker()
        
        instance.preparaData()
        return instance
    }()
    
    private var allDataFile: [DatePeriod] = [
        .month,
        .week
    ]
    
    func preparaData() {
        let decoder = JSONDecoder()
        for file in allDataFile {
            guard
                let url = Bundle.main.url(forResource: file.fileName, withExtension: "json"),
                let data = try? Data(contentsOf: url),
                let fileContent = try? decoder.decode(FileContent.self, from: data)
            else {
                preconditionFailure("Wrong file: \(file.fileName) structure")
            }
            switch file {
            case .month:
                self.weekData = fileContent.content
            case .week:
                self.monthData = fileContent.content
            }
        }
    }
    
    func getCandleData(period: DatePeriod) -> [ChartDataSetProtocol] {
        let source : [QuoteSymbol]
        switch period {
        case .month:
            source = monthData.quoteSymbols
        case .week:
            source = weekData.quoteSymbols
        }
        
        var result = [ChartDataSetProtocol]()
        
        for quoteSymbol in source {
            let mainColor = UIColor.random()
            let values = (0..<quoteSymbol.timestamps.count).map { (index) -> CandleChartDataEntry in
                let xValue = quoteSymbol.timestamps[index]
                let shadowH = quoteSymbol.highs[index]
                let shadowL = quoteSymbol.lows[index]
                let openValue = quoteSymbol.opens[index]
                let closeValue = quoteSymbol.closures[index]
                let data = Date(timeIntervalSince1970: TimeInterval(quoteSymbol.timestamps[index]))
                print(data)
                return CandleChartDataEntry(
                    x: Double(xValue),
                    shadowH: shadowH,
                    shadowL: shadowL,
                    open: openValue,
                    close: closeValue,
                    data: data)
            }
            
            let dataSet = CandleChartDataSet(entries: values, label: quoteSymbol.symbol)
            dataSet.axisDependency = .left
            dataSet.setColor(UIColor(white: 80/255, alpha: 1))
            dataSet.drawIconsEnabled = false
            dataSet.shadowColor = .darkGray
            dataSet.shadowWidth = 5
            dataSet.decreasingColor = mainColor
            dataSet.decreasingFilled = true
            dataSet.increasingColor = mainColor
            dataSet.increasingFilled = false
            dataSet.neutralColor = mainColor
            result.append(dataSet)
        }
        return result
    }
    
    func getLineData(period: DatePeriod) -> [ChartDataSetProtocol] {
        let source : [QuoteSymbol]
        switch period {
        case .month:
            source = monthData.quoteSymbols
        case .week:
            source = weekData.quoteSymbols
        }
        
        var result = [ChartDataSetProtocol]()
        for quoteSymbol in source {
            let mainColor = UIColor.random()
            let values = (0..<quoteSymbol.timestamps.count).map { (index) -> ChartDataEntry in
                let xValue = quoteSymbol.timestamps[index]
                let value = quoteSymbol.volumes[index]
                return ChartDataEntry(x: Double(xValue), y: Double(value))
            }
            let set = LineChartDataSet(entries: values, label: quoteSymbol.symbol)
            set.setColor(mainColor)
            set.circleRadius = 3
            set.setCircleColor(mainColor)
            result.append(set)
        }
        return result
    }
}
