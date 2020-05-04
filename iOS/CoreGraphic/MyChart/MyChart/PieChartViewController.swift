//
//  SecondViewController.swift
//  MyChart
//
//  Created by 신한섭 on 2020/05/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class PieChartViewController: UIViewController {

    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pieChartView.setGraph(element: [1,3,2,3,5])
    }
}

