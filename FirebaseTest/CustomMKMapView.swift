//
//  CustomMKMapView.swift
//  FirebaseTest
//
//  Created by David on 28/2/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import MapKit

class CustomMKMapView: MKMapView {
    
    var tileOverlay: CacheTileOverlay? = nil
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        self.initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initialize()
    }
    
    private func initialize() {
        if let tileOverlay = self.tileOverlay {
            self.remove(tileOverlay)
        }
        
        let urlTemplate = "https://stamen-tiles.a.ssl.fastly.net/watercolor/{z}/{x}/{y}.jpg"
        
        //let urlTemplate = "http://tile.stamen.com/watercolor/{z}/{x}/{y}.jpg"
        
        
        //let urlTemplate = "https://api.mapbox.com/styles/v1/damarte/ciu9m2v01001c2ipsv84u4mb9/tiles/256/{z}/{x}/{y}@2x?access_token=pk.eyJ1IjoiZGFtYXJ0ZSIsImEiOiJjaXU5bTF5ZGgwMDJlMnRsaW82OHBzejFtIn0.ZW21GxFV2SBFsFxosiS42Q"
        
        self.tileOverlay = CacheTileOverlay(urlTemplate: urlTemplate)
        if let tileOverlay = self.tileOverlay {
            tileOverlay.canReplaceMapContent = true
            tileOverlay.maximumZ = 22
            tileOverlay.minimumZ = 5
            tileOverlay.tileSize = CGSize(width: 256, height: 256)
            self.add(tileOverlay, level: .aboveLabels)
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
