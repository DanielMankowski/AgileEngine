//
//  PhotosMother.swift
//  AgileEngineChallengeTests
//
//  Created by OLX - Daniel on 18/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import Foundation

@testable import AgileEngineChallenge

class PhotosMother {
    class func createFlickrPhotos(withTitle text: String) -> FlickrPhoto {
        let data = Data("""
            {
            "id": "48314132087",
            "owner": "10485077@N06",
            "secret": "96a03a2d02",
            "server": "65535", "farm": 66,
            "title": "Meditating Cats & Dogs",
            "ispublic": 1,
            "isfriend": 0,
            "isfamily": 0
            }
            """.utf8)
        return try! JSONDecoder().decode(FlickrPhoto.self, from: data)
    }
}

