//
//  ImageLibrary.m
//  PhotoGallery
//
//  Created by Dan Vasilyonok on 5/7/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import "ImageLibrary.h"

//Thought I needed this framework at first, but builtin JSONSerialization takes care of
//converting jsonData to a parsable dictionairy
//#import <SBJson4.h>

@implementation ImageLibrary

NSString *const FlickrAPIKey = @"81d78a591edd8080ddd6e0cee6c12ffe";

- (id)init
{
    if (self = [super init])
    {
        //[self initImageArrays];
        //[self loadFlickrPhotosAndSearch:@"beach"];
    }
    return self;
}

-(void)initImageArrays
{
    self.photoURLsLarge = [[NSMutableArray alloc]init];
    self.imageData = [[NSMutableArray alloc]init];
    self.photoNames = [[NSMutableArray alloc]init];

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

//Flickr API request
-(void)loadFlickrPhotosAndSearch:(NSString *)keyWord AndReload:(UICollectionView *)collectionView
{
    /* REST request format
     http://api.flickr.com/services/rest/?method=flickr.test.echo&name=value
     */
    
    /*https for secure connection*/
    NSString *urlString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=25&format=json&nojsoncallback=1", FlickrAPIKey, keyWord];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    //Initialize & Begin asynchronous download
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithRequest:request
                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                    [self receiveJSONData:data];
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //reload collectionview after downloading images
                        [collectionView reloadData];
                        //NSLog(@"Reloaded collectionview...");
                    });
                }]resume];

    //Change to NSURL Session
    //NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    //ARC takes care of releasing request and connection
    
}

-(void)receiveJSONData:(NSData*)data
{
    int imageCount = 0;
    
    //json is stored in dictionary format
    NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    //check if succesful connection and view returned images
    [self checkJSONRequest:jsonResult];
    
    NSArray *photos = [[jsonResult objectForKey:@"photos"]objectForKey:@"photo"];
    
    //iterate though photos array, each element is a dictionairy
    for(NSDictionary *photo in photos) {
        
        imageCount++;
        NSLog(@"Looping through dictionary, Current Image Count: %i\n", imageCount);
        
        NSString *title = [photo objectForKey:@"title"];
        
        /*Populate array: store requested titles of images in photoNames*/
        [self.photoNames addObject:(title.length > 0 ? title : @"Untitled")];
        
        //"_s" request small image 75x75 pixels
        NSString *photoURLString =
        [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_s.jpg",
         [photo objectForKey:@"farm"], [photo objectForKey:@"server"],
         [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        
        NSLog(@"photoURLString: %@", photoURLString);
        
        /*Populate array: store requested small image data in imageData array*/
        //[self.imageData addObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:photoURLString]]];
        [self.imageData addObject:[NSURL URLWithString:photoURLString]];
        
        //"_m" requests larger image
        photoURLString =
        [NSString stringWithFormat:@"http://farm%@.static.flickr.com/%@/%@_%@_m.jpg",
         [photo objectForKey:@"farm"], [photo objectForKey:@"server"],
         [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        
        /*Populate array: store requested large image URLs in photosURLsLarge*/
        [self.photoURLsLarge addObject:[NSURL URLWithString:photoURLString]];
        
        NSLog(@"photoURLsLareImage: %@\n\n", photoURLString);
    }
    
    /*Check if populated succesfully*/
    /*
     NSLog(@"(Inside SDK)Number of Photos: %lu", [self.photoNames count]);
     NSLog(@"(Inside SDK)Number of Photos: %lu", [self.imageData count]);
     NSLog(@"(Inside SDK)Number of Photos: %lu", [self.photoURLsLarge count]);
     */
     
}

/*
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self receiveJSONData:data];
}
 */

@end
