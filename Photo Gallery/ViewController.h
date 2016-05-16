//
//  ViewController.h
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomFlowLayout.h"
#import "PhotoCell.h"
#import "DetailViewController.h"
#import "FlickrClient.h"
#import "LibraryAPI.h"

@interface ViewController : UIViewController<UICollectionViewDataSource, FlickrClientDelegate, LibraryAPIDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(strong, nonatomic) PhotoCell *cell;

@end

