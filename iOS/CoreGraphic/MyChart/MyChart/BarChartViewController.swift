//
//  FirstViewController.swift
//  MyChart
//
//  Created by 신한섭 on 2020/05/03.
//  Copyright © 2020 신한섭. All rights reserved.
//

import UIKit

class BarChartViewController: UIViewController {

    @IBOutlet weak var barChartView: BarChartView! 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        barChartView.setGraph(element: [10,90,30,10,40,90,20])
    }
}

