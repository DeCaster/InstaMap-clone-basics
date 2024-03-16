//
//  PlaceModel.swift
//  FoursquareClone
//
//  Created by Murad Eyvazli on 11.02.2024
//  Copyright © 2024 Murad Eyvazli. All rights reserved.
//

import Foundation
import UIKit

class PlaceModel {
    
    static let sharedInstance = PlaceModel()
    
    var placeName = ""
    var placeType = ""
    var placeAtmosphere = ""
    var placeImage = UIImage()
    var placeLatitude = ""
    var placeLongitude = ""
    
    private init(){}
    
}
