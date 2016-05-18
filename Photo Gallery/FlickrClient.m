//
//  FlickrClient.m
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

/*
 Although called FlickrClient, this API interfaces with both the Flickr API
 and Imgur API using GET requests to fetch images and populate the Photo Model
 */

#import "FlickrClient.h"
#import "LibraryAPI.h"
#import "Photo.h"

@implementation FlickrClient
{
    LibraryAPI *libraryAPI;
    Photo *webserverPhoto;
    
    /*Stored in Photo Model*/
    NSString *title;
    NSURL *imageURL;
    NSString *imageURLString;
    UIImage *realImage;
    NSArray *photosFromWeb;
    
    UICollectionView *collectionView;
}

-(void)refreshUIOnMainThread
{
    photosFromWeb = [libraryAPI getPhotos];
    /*
    dispatch_async(dispatch_get_main_queue(), ^{
        if([self.delegate respondsToSelector:@selector(reloadUIAfterImageDownload:)]) {
            [self.delegate reloadUIAfterImageDownload:photosFromWeb];
        }
    });
     */
    if([self.delegate respondsToSelector:@selector(reloadUIAfterImageDownload:)]) {
        [self.delegate reloadUIAfterImageDownload:photosFromWeb];
    }
}

- (id)getRequestFlickr:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        /*Parse JSON result*/
        [self receiveJSONDataFromFlickr:data];
        
        /*Use delegate to tell View Controller to call a reloadUI function after image download on main thread*/
        
        /*responds to selector returns YES if the delegate class, ViewController in this case
        has implemented the reloadUIAfterImageDownload declared in the protocol*/
        [self refreshUIOnMainThread];
        
    }];
    [task resume];
    
    return nil;
    
}

-(id)getRequestImgur:(NSString*)urlString ImgurAPIKey:(NSString *)APIKey
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setValue:APIKey forHTTPHeaderField:@"Authorization"];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession]dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        /*Parse returned JSON to extract image data and add to photo model*/
        [self receiveJSONDataFromImgur:data];
        
        /*Use delegate to tell View Controller to call a reloadUI function after image download on main thread*/
        [self refreshUIOnMainThread];
        
    }];
    [task resume];
    
    return nil;
}

/*Check JSON Request Result
 1. Returns the key value pairs to verify succesful connection
 2. Returns photos dictionairy, specifically with key: photos who's value is
 an array of each photo returned from Flickr
 */
-(void)checkJSONRequest:(NSDictionary *)jsonResult
{
    NSLog(@"Parsing JSON Request Result...\n");
    [jsonResult enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"The key is: %@", key);
        NSLog(@"The value is: %@", obj);
    }];
}

-(void)receiveJSONDataFromImgur:(NSData*)data
{
    NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    //[self checkJSONRequest:jsonResult];
    
    /*want title and link data from json result*/
    NSArray *photos = [jsonResult objectForKey:@"data"];
    
    for(NSDictionary *photo in photos) {
        title = [photo objectForKey:@"title"];
        
        imageURLString = [photo objectForKey:@"link"];
        imageURL = [NSURL URLWithString:imageURLString];
        
        NSLog(@"Imgur: title: %@ and URL: %@\n\n", title, imageURLString);
        
        webserverPhoto = [[Photo alloc]initWithTitle:title AndImageURL:imageURL AndUIImage:nil];
        
        libraryAPI = [LibraryAPI sharedInstance];
        [libraryAPI addPhoto:webserverPhoto];
    }
    
    NSLog(@"Imgur Server Photos added to model\n");
    
}

//Storing title -NSString and imageURL -NSURL
-(void)receiveJSONDataFromFlickr:(NSData*)data
{
    //json is stored in dictionary format
    NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    //check if succesful connection and view returned images
    //[self checkJSONRequest:jsonResult];
    
    //array where each element is a dictionairy where each key is a photoid and value is
    //the different metadata
    NSArray *photos = [[jsonResult objectForKey:@"photos"]objectForKey:@"photo"];
    
    //iterate though photos array, each element is a dictionairy
    for(NSDictionary *photo in photos) {
        
        //GET NSString title property for photo model
        title = [photo objectForKey:@"title"];
        
        //"_m" requests larger image
        NSString *photoURLString =
        [NSString stringWithFormat:@"https://farm%@.static.flickr.com/%@/%@_%@_m.jpg",
         [photo objectForKey:@"farm"], [photo objectForKey:@"server"],
         [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        
        /*GET imageURL for photo model*/
        imageURL = [NSURL URLWithString:photoURLString];
        
        NSLog(@"Flickr: title: %@ and URL: %@\n\n", title, photoURLString);
        
        //Store title property and imageURL in photo model
        webserverPhoto = [[Photo alloc]initWithTitle:title AndImageURL:imageURL AndUIImage:nil];
        
        /*Populate Photo model array*/
        libraryAPI = [LibraryAPI sharedInstance];
        [libraryAPI addPhoto:webserverPhoto];
    }
    
    NSLog(@"Flickr Server Photos added to Model");
}

@end
