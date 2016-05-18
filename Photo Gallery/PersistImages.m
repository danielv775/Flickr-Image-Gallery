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
        
        /*@image1 is not a path, must save to local directory first
        
        NSURL *localImage1 = [[NSURL alloc]initFileURLWithPath:@"image1"];
        NSURL *localImage2 = [[NSURL alloc]initFileURLWithPath:@"image2"];
        NSURL *localImage3 = [[NSURL alloc]initFileURLWithPath:@"image3"];
        
        Saving UIImage to a local directory, I can get rid of UIImage parameter in init function, and use
        [NSURL alloc]initFileURLWithPath:@"filePath"] when passing as imageURL
         */
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
