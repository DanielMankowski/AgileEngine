//
//  SearchTest.swift
//  AgileEngineChallengeTests
//
//  Created by OLX - Daniel on 18/07/2019.
//  Copyright © 2019 Daniel Mankowski. All rights reserved.
//

import XCTest
@testable import AgileEngineChallenge

class SearchTest: XCTestCase {
    var photos: [Photo]!
    var photosRepository: PhotosMock!
    
    override func setUp() {
        photos = givenSomePhotos()
        photosRepository = givenSearchRepository(withPhotos: photos)
    }
    
    func test_search_photo_by_exact_keyword() {
        //Given
        let search = SearchPhotos(photosRepository: photosRepository)
        let expectation = self.expectation(description: "Search Block")
        var searchResult: SearchPhotosResult?
        
        //When
        _ = search.invoke(text: "Meditating Cats & Dogs", completion: { (result) in
            searchResult = result
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        //Verify
        if case let SearchPhotosResult.success(photos: photosResult) = searchResult! {
            XCTAssertEqual(self.photos.count, photosResult.count)
        } else {
            XCTFail("SearchResult was not successful")
        }
    }
    
    func test_search_photo_by_part_of_its_title() {
        //Given
        let search = SearchPhotos(photosRepository: photosRepository)
        let expectation = self.expectation(description: "Search Block")
        var searchResult: SearchPhotosResult?
        
        //When
        _ = search.invoke(text: "Cats", completion: { (result) in
            searchResult = result
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        //Verify
        if case let SearchPhotosResult.success(photos: photosResult) = searchResult! {
            XCTAssertEqual(self.photos.count, photosResult.count)
        } else {
            XCTFail("SearchResult was not successful")
        }
    }
    
    func test_failing_finding_unexist_photo() {
        //Given
        let search = SearchPhotos(photosRepository: photosRepository)
        let expectation = self.expectation(description: "Search Block")
        var searchResult: SearchPhotosResult?
        
        //When
        _ = search.invoke(text: "fkjsabfjksbvbnzkljxhv", completion: { (result) in
            searchResult = result
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        //Verify
        if case let SearchPhotosResult.failure(errorType) = searchResult! {
            XCTAssertEqual(.notFound, errorType)
        } else {
            XCTFail("Search found results when it shouldn't")
        }
    }
    
    func test_search_fails_triggering_it_with_less_three_3_letters() {
        //Given
        let search = SearchPhotos(photosRepository: photosRepository)
        let expectation = self.expectation(description: "Search Block")
        var searchResult: SearchPhotosResult?
        
        //When
        _ = search.invoke(text: "ab", completion: { (result) in
            searchResult = result
            expectation.fulfill()
        })
        
        waitForExpectations(timeout: 1.0, handler: nil)
        
        //Verify
        if case let SearchPhotosResult.failure(errorType) = searchResult! {
            XCTAssertEqual(.keywordLength, errorType)
        } else {
            XCTFail("Search found results when it shouldn't")
        }
    }
    
    private func givenSomePhotos() -> [Photo] {
        let flickrPhotos = PhotosMother.createFlickrPhotos(withTitle: "Dog")
        let photos = PhotosFactory().createPhoto(fromFlickr: flickrPhotos)
        return [photos]
    }
    
    private func givenSearchRepository(withPhotos photos: [Photo]) -> PhotosMock {
        return PhotosMock(withPhotos: photos)
    }
}
