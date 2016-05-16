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
Communicates with Flickr Server API and Instagram API
 */

/*Flickr API Keys and KeyWord*/
NSString *const FlickrAPIKey = @"81d78a591edd8080ddd6e0cee6c12ffe";
NSString *const keyWord = @"beach";

@implementation LibraryAPI
{
    PersistImages *persistImages;
    FlickrClient *flickrClient;
    NSString *requestString;
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
        //Local Images
        persistImages = [[PersistImages alloc]init];
        
        //Web server images from Flickr and Instagram
        flickrClient = [[FlickrClient alloc]init];
        if([self.delegate respondsToSelector:@selector(passFlickerInstance:)]) {
            [self.delegate passFlickerInstance:flickrClient];
        }
        [self fetchPhotosFromServer:FlickrAPIKey withKeyWord:keyWord];
    }
    return self;
}

-(void)fetchPhotosFromServer:(NSString*)APIKey withKeyWord:(NSString*)keyWord
{
    /*Construct String to pass GET Request*/
    requestString = [NSString stringWithFormat:@"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=%@&tags=%@&per_page=25&format=json&nojsoncallback=1",APIKey,keyWord];
    
    /*Fetch images and populate Photo Model*/
    [flickrClient getRequest:requestString];
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
