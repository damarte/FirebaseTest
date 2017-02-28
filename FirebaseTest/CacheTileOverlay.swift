//
//  CacheTileOverlay.swift
//  FirebaseTest
//
//  Created by David on 28/2/17.
//  Copyright © 2017 David. All rights reserved.
//

import UIKit
import MapKit

class CacheTileOverlay: MKTileOverlay {

    var operationQueue = OperationQueue()
    
    override init(urlTemplate URLTemplate: String?) {
        super.init(urlTemplate: URLTemplate)
        
        operationQueue.name = "CacheTileOverlayQueue"
        operationQueue.maxConcurrentOperationCount = 3
    }
    
    override func loadTile(at path: MKTileOverlayPath, result: @escaping (Data?, Error?) -> Void) {
        let request = URLRequest(url: self.url(forTilePath: path), cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 3)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
            }
            
            result(data, error)
        }
        
        task.resume()
    }
}
