//
//  Photo.m
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(id)initWithTitle:(NSString *)title AndImageURL:(NSURL *)imageURL AndUIImage:(UIImage *)image;
{
    self = [super init];
    if(self) {
        self.title = title;
        self.imageURL = imageURL;
        self.image = image;
    }
    return self;
}


@end
