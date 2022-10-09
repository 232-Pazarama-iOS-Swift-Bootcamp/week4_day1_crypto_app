//
//  ChartResponse.swift
//  Crypto App
//
//  Created by Pazarama iOS Bootcamp on 9.10.2022.
//

import Foundation

struct ChartResponse: Decodable {
    let chart: [[Double]]?
}
