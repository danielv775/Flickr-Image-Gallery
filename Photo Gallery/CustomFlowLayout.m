//
//  CustomFlowLayout.m
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import "CustomFlowLayout.h"

@implementation CustomFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.minimumLineSpacing = 1.0;
        self.minimumInteritemSpacing = 1.0;
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    return self;
}

- (CGSize)itemSize
{
    NSInteger numberOfColumns = 3;
    //collectionview width / number of columns
    CGFloat itemWidth = (CGRectGetWidth(self.collectionView.frame) - (numberOfColumns - 1)) / numberOfColumns;
    return CGSizeMake(itemWidth, itemWidth);
}

@end
