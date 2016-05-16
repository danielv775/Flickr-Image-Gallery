//
//  PersistImages.h
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Photo.h"

@interface PersistImages : NSObject

-(NSArray*)getPhotos;
-(void)addPhoto:(Photo *)photo;
-(void)deletePhotoAtIndex:(int)index;

@end
