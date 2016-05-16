//
//  FlickrClient.m
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

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
    UIImage *realImage;
}

- (id)getRequest:(NSString*)urlString
{
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url];
    
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        /*Parse JSON result*/
        [self receiveJSONData:data];
        if([self.delegate respondsToSelector:@selector(reloadUIAfterImageDownload)]) {
            NSLog(@"Responded to Selector");
            [self.delegate reloadUIAfterImageDownload];
        }
        
        /*Use delegate to tell View Controller to call a reloadUI function after image download*/
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"Hello...");
            if([self.delegate respondsToSelector:@selector(reloadUIAfterImageDownload)]) {
                NSLog(@"Calling delegate after download soon...\n");
                [self.delegate reloadUIAfterImageDownload];
            }
        });
        
        NSLog(@"Finished...");
        
        /*After url data is fetched from server, the UI must be reloaded on the main thread*/
        
    }];
    [task resume];
    
    return nil;
    
}

- (UIImage*)downloadImage:(NSURL*)url
{
    NSData *data = [NSData dataWithContentsOfURL:url];
    return [UIImage imageWithData:data];
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



//Storing title -NSString and imageURL -NSURL
-(void)receiveJSONData:(NSData*)data
{
    //json is stored in dictionary format
    NSDictionary *jsonResult = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    //check if succesful connection and view returned images
    [self checkJSONRequest:jsonResult];
    
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
        
        /*Download UIImage for photo model asynch*/
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            realImage = [self downloadImage:imageURL];
        });
         
        //realImage = [self downloadImage:imageURL];
        
        //Store title property and imageURL in photo model
        webserverPhoto = [[Photo alloc]initWithTitle:title AndImageURL:imageURL AndUIImage:realImage];
        
        /*Populate Photo model array*/
        [libraryAPI addPhoto:webserverPhoto];
    }
    
    NSLog(@"Web Server Photos added to Model");
    
    /*
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"Hello...");
        id<FlickrClientDelegate> strongDelegate = self.delegate;
        if([strongDelegate respondsToSelector:@selector(reloadUIAfterImageDownload)]) {
            NSLog(@"Calling delegate after download soon...\n");
            [strongDelegate reloadUIAfterImageDownload];
        }
    });
    NSLog(@"Finished...");
     */
}

@end
