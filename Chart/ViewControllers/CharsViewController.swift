//
//  ViewController.swift
//  Chart
//
//  Created by Sergey on 06.05.2022.
//

import UIKit
import Charts

class CharsViewController: UIViewController {
    
    @IBOutlet private var candleChartView: CandleStickChartView!
    @IBOutlet private var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        [candleChartView, lineChartView].forEach({ configureChartView(view: $0)})
        configureView(period: .month)
    }

    private func configureView(period: DatePeriod) {
        candleChartView.data = CandleChartData(dataSets: ChartDataWorker.shared.getCandleData(period: period))
        lineChartView.data = LineChartData(dataSets: ChartDataWorker.shared.getLineData(period: period))
    }
    
// MARK: - Configure methods -
    private func configureChartView(view: BarLineChartViewBase) {
        view.chartDescription.enabled = false
    
        view.dragEnabled = true
        view.setScaleEnabled(true)
        view.maxVisibleCount = 200
        view.pinchZoomEnabled = true
        
        view.legend.horizontalAlignment = .left
        view.legend.verticalAlignment = .bottom
        view.legend.drawInside = false
        
        view.leftAxis.spaceTop = 0.3
        view.leftAxis.spaceBottom = 0.3
        view.leftAxis.axisMinimum = 0
        
        view.rightAxis.enabled = false
        
        view.xAxis.labelPosition = .bottom
        
        view.xAxis.valueFormatter = XAxisNameFormater()
    }
    
    @IBAction func periodChanged(_ sender: UISegmentedControl) {
        let period: DatePeriod = sender.selectedSegmentIndex == 0 ? .month : .week
        configureView(period: period)
    }
}
