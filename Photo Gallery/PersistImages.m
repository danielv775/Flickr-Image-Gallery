//
//  PersistImages.m
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import "PersistImages.h"


@implementation PersistImages {
    NSMutableArray *photos;
}

-(id)init
{
    self = [super init];
    if(self) {
        /*populate photos array with sample photos*/
        photos = [NSMutableArray arrayWithArray:
                  @[[[Photo alloc] initWithTitle:@"Oliver1" AndImageURL:nil AndUIImage:[UIImage imageNamed:@"image1"]],
                    [[Photo alloc] initWithTitle:@"Oliver2" AndImageURL:nil AndUIImage:[UIImage imageNamed:@"image2"]],
                    [[Photo alloc] initWithTitle:@"FancyRoom" AndImageURL:nil AndUIImage:[UIImage imageNamed:@"image3"]]]];
    }
    return self;
}
                  
-(NSArray*)getPhotos
{
    return photos;
}

-(void)addPhoto:(Photo *)photo
{
    [photos addObject:photo];
}

-(void)deletePhotoAtIndex:(int)index
{
    [photos removeObjectAtIndex:index];
}
                  

@end
