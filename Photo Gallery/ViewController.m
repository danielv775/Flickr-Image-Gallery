//
//  ViewController.m
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface ViewController ()
{
    NSArray *allPhotos;
    Photo *displayPhoto;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*Retrieve Photo Model array*/
    LibraryAPI *libraryAPI = [LibraryAPI sharedInstance];
    libraryAPI.flickrClient.delegate = self;
    allPhotos = [libraryAPI getPhotos];
    
    NSLog(@"ViewDidLoad: Number of Photos in Photo Model: %lu\n", (unsigned long)[allPhotos count]);
    
    self.collectionView.collectionViewLayout = [[CustomFlowLayout alloc] init];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self changeNavBarAttributes];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - collectionView methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    /*reduce lag*/
    self.cell.layer.shouldRasterize = YES;
    self.cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    /*Pull photo from Photo model Array, imageURL property should be populated after URLs are fetched
     from Flickr and Imgur*/
    displayPhoto = [allPhotos objectAtIndex:indexPath.item];
    
    [self.cell.imageView sd_setImageWithURL:displayPhoto.imageURL placeholderImage:displayPhoto.image];
        
    return self.cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    /*Initially, 3 photos from assets.xcassets*/
    /*After Photo Model populated with data from Flickr and Imgur, should increase*/
    /*After reloadData called, this should be called again with the new count*/
    
    NSLog(@"numberofItemsInSection: Number of Photos in Photo Model: %lu\n", (unsigned long)[allPhotos count]);
    return ([allPhotos count]);
}

#pragma mark FlickrClient Delegate Method
-(void)reloadUIAfterImageDownload
{
    LibraryAPI *libraryAPI = [LibraryAPI sharedInstance];
    allPhotos = [libraryAPI getPhotos];
    NSLog(@"reloadUIAfterDelegate: Number of Photos in Photo Model: %lu\n", (unsigned long)[allPhotos count]);
    
    dispatch_async(dispatch_get_main_queue(), ^{
        NSLog(@"about to reload collectionview...\n");
        [self.collectionView reloadData];
    });
    
}
 

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*DetailViewController is destination*/
    DetailViewController *detailView = [[DetailViewController alloc]init];
    
    if([segue.identifier isEqualToString:@"showFullPhoto"]) {
        detailView = segue.destinationViewController;
        
        /*index of image in collection view*/
        NSIndexPath *index = [[NSIndexPath alloc]init];
        index = [self.collectionView indexPathForCell:sender];
        
        displayPhoto = [allPhotos objectAtIndex:index.item];
        detailView.displayPhoto = displayPhoto;
    }
    
}

-(void)changeNavBarAttributes
{
    //self.navigationItem.titleView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"barGallery"]];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
}

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

@end
