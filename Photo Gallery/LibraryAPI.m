//
//  LibraryAPI.m
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import "LibraryAPI.h"
#import "PersistImages.h"


/*Central API that gives access to Photo Model
Communicates with Local Image Storage(Persis Images) class
Communicates with Flickr Server API and Imgur API
 */

/*Flickr API Keys and KeyWord*/
NSString *const FlickrAPIKey = @"81d78a591edd8080ddd6e0cee6c12ffe";
NSString *const keyWord = @"beach";

/*Imgur API Keys and KeyWord*/
NSString *const ImgurAPIKey = @"Client-ID f09ef8e931a94b0";
NSString *const ImgurAPISecretKey = @"7f21e67831cf9b3d062f81064e5a70bda86663dd";

@implementation LibraryAPI
{
    PersistImages *persistImages;
    FlickrClient *flickrClient;
    NSString *requestStringFlickr;
    
    NSString *requestStringImgur;
}

+(LibraryAPI*)sharedInstance {

    static LibraryAPI *sharedInstance = nil;
    
    /*make sure init code executes only once*/
    static dispatch_once_t oncePredicate;
    
    /*initialize API data service class only once*/
    dispatch_once(&oncePredicate, ^{
        sharedInstance = [[LibraryAPI alloc]init];
    });
    
    return sharedInstance;
    
}

-(id)init
{
    self = [super init];
    if(self) {
        /*Local Image Storage*/
        persistImages = [[PersistImages alloc]init];
        
        /*Web server images from Flickr and Imgur*/
        flickrClient = [[FlickrClient alloc]init];
        
        /*Fetch Photos from Flickr*/
        //[self fetchPhotosFromFlickrServer:FlickrAPIKey withKeyWord:keyWord];
        
        /*Fetch Photos from Imgur*/
        [self fetchPhotosFromImgurServer:ImgurAPIKey];
    }
    return self;
}

-(void)fetchPhotosFromFlickrServer:(NSString*)APIKey withKeyWord:(NSString*)keyWord
{
    /*Construct String to pass GET Request*/
    requestStringFlickr = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=25&format=json&nojsoncallback=1",APIKey,keyWord];
    
    /*Fetch images and populate Photo Model*/
    [flickrClient getRequestFlickr:requestStringFlickr];
}

-(void)fetchPhotosFromImgurServer:(NSString*)APIKey
{
    /*String to pass to GET Request*/
    requestStringImgur = @"https://api.imgur.com/3/gallery/r/earthporn/time/";
    
    /*Fetch Images and populate Photo Model*/
    [flickrClient getRequestImgur:requestStringImgur ImgurAPIKey:APIKey];
}


-(NSArray*)getPhotos
{
    /*Returns Photo model*/
    return [persistImages getPhotos];
}

-(void)addPhoto:(Photo *)photo
{
    [persistImages addPhoto:photo];
}

-(void)deletePhotoAtIndex:(int)index
{
    [persistImages deletePhotoAtIndex:index];
}

@end
