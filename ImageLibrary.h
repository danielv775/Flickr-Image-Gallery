//
//  ImageLibrary.h
//  PhotoGallery
//
//  Created by Dan Vasilyonok on 5/7/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/*
 
 API pulls images from Flickr to display in UICollectionView
 
 flickr key
 81d78a591edd8080ddd6e0cee6c12ffe
 
 */

@interface ImageLibrary : NSObject

//Store image names and data
@property(nonatomic, strong) NSMutableArray *photoNames; //Title of images
@property(nonatomic, strong) NSMutableArray *imageData;  //Image Data(thumbnail)
@property(nonatomic, strong) NSMutableArray *photoURLsLarge;  //URL to large image

//init arrays
-(void)initImageArrays;

//load images from flickr, and search based on keyWord
-(void)loadFlickrPhotosAndSearch:(NSString *)keyWord AndReload:(UICollectionView *)collectionView;

//Handle image data received from Flickr, and store into arrays
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;

@end
