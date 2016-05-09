//
//  ViewPhotoCell.m
//  PhotoGallery
//
//  Created by Dan Vasilyonok on 5/7/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import "ViewPhotoCell.h"

@implementation ViewPhotoCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.imageView.image = nil;
    //self.imageView.contentMode = UIViewContentModeScaleAspectFill;
}

@end
