//
//  ViewController.h
//  PhotoGallery
//
//  Created by Dan Vasilyonok on 5/7/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewPhotoCell.h"
#import "ImageLibrary.h"

@interface ViewController : UIViewController <UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property(nonatomic, strong) ViewPhotoCell *cell;

/*Flickr SDK*/
@property(nonatomic, strong) ImageLibrary *flickrAPI;
@property(nonatomic, strong) NSMutableArray *photoNames; //Title of images
@property(nonatomic, strong) NSMutableArray *imageData;  //Image Data(thumbnail)
@property(nonatomic, strong) NSMutableArray *photoURLsLarge;  //URL to large image

@property(atomic) int loadCount;

@end

