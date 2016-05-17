//
//  LibraryAPI.h
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"
#import "FlickrClient.h"

/*Using this LibraryAPI demonstrates the Facade Design Pattern*/

@interface LibraryAPI : NSObject

+(LibraryAPI *)sharedInstance;

-(NSArray*)getPhotos;
-(void)addPhoto:(Photo *)photo;
-(void)deletePhotoAtIndex:(int)index;
-(void)fetchPhotosFromFlickrServer:(NSString*)APIKey withKeyWord:(NSString*)keyWord;
-(void)fetchPhotosFromImgurServer:(NSString*)APIKey;


@end
