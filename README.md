# AgileEngine

This is an example project as interview processing.

## Project Architecture
I have chosen IDD architecture to make the project, always trying to meet SOLID metodology. For that I was tried to create actions in order to show quickly what is the main features project.
If you are intersting, this an article about that: [Introducing Interaction-Driven Design](https://codurance.com/2017/12/08/introducing-idd/)

## Technical Details
In order to demonstrate knowledgment I think that the most appropiate way to do the project is as native as possible, so I am going to list the components that I have used and what library I could have used.
- For API calls: **URLSession and URLSessionTask**. Both are executed in background y implements cache by default. I could have use Alamofire or AFNetwork
- For download images: I have used SDWebImage library, added to project by CocoaPods. (when dowload proyect, please do not forget to execute pod install in console).

## Requirements
- Main grid list 2-column photos
- Portrait and Landscape orientation
- Photo Detail screen
- Panning for images
- Unit test

## Clarifications
By time reasons in screens are missing refreshs (UIActivityIndicator) and show error messages if some error happens. By example at the moment to call API (UIAlertController).
Besides, the API provided in the challenge is shut down (https://support.500px.com/hc/en-us/articles/360002435653-API-), so I have decided to use Flickr API that is similar (https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=1947eedcd881a72fe3a59d405a7efea4&format=json). I spent a little more time because of that.

## Improvements
- Save last searches: I made model data codable in order to pesist it easily.
- Pull to refresh in gallery
- Zoom in photos
- Error alerts
- Final condition for pagination
