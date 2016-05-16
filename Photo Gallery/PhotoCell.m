//
//  PhotoCell.m
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import "PhotoCell.h"

@implementation PhotoCell

- (void)prepareForReuse
{
    [super prepareForReuse];
    self.imageView.image = nil;
    
    //self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    //self.imageView.contentMode = UIViewContentModeCenter;
}

@end
