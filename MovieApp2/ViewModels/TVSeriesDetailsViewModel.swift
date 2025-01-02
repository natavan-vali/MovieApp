//
//  TVSeriesDetailsViewModel.swift
//  MovieApp
//
//  Created by Natavan Valiyeva on 26.11.24.
//


import UIKit
import Alamofire

class TVSeriesDetailsViewModel {
    var selectedSeriesId: Int?
    var selectedSeries: TVSeries?
    var success: ((TVSeries) -> ())?
    var error: ((String) -> ())?
    
    func fetchTVSeriesDetails() {
        TVSeriesDetailsManager.fetchTVSeriesDetails(id: selectedSeriesId ?? 0) { seriesDetails, errorMessage in
            if let errorMessage = errorMessage {
                self.error?(errorMessage)
                return
            }
            
            guard let seriesDetails = seriesDetails else {
                self.error?("Series details are missing.")
                return
            }
    
            DispatchQueue.main.async {
                self.success?(seriesDetails)
            }
        }
    }
}
