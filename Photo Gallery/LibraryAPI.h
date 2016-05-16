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

@protocol LibraryAPIDelegate <NSObject>

-(void)passFlickerInstance:(FlickrClient*)flickr;

@end

@interface LibraryAPI : NSObject

+(LibraryAPI *)sharedInstance;

@property (weak, nonatomic) id <LibraryAPIDelegate> delegate;

-(NSArray*)getPhotos;
-(void)addPhoto:(Photo *)photo;
-(void)deletePhotoAtIndex:(int)index;
-(void)fetchPhotosFromServer:(NSString*)APIKey withKeyWord:(NSString*)keyWord;

@end
