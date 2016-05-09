//
//  ViewPhotoCell.h
//  PhotoGallery
//
//  Created by Dan Vasilyonok on 5/7/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewPhotoCell : UICollectionViewCell

/* By creating a custom UICollectionview cell, a cached version of the cell
is used and saves some memory; the cell does not need to be created from scratch
 */
@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end
