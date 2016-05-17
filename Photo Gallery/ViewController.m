//
//  ViewController.m
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import "ViewController.h"
#import "Photo.h"

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
    allPhotos = [libraryAPI getPhotos];
    
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
    
    /*Pull photo from Photo model Array*/
    displayPhoto = [allPhotos objectAtIndex:indexPath.item];
    self.cell.imageView.image = displayPhoto.image;
    
    /*Test images from assets*/
    /*
    NSString *imageName = [[NSString alloc]init];
    if(indexPath.row % 3 == 0) {
        imageName = @"image1";
    }
    else if(indexPath.row % 3 == 1) {
        imageName = @"image2";
    }
    else if(indexPath.row % 3 == 2) {
        imageName = @"image3";
    }
    self.cell.imageView.image = [UIImage imageNamed:imageName];
     */
    
    return self.cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSLog(@"Number of Photos in Photo Model: %lu", (unsigned long)[allPhotos count]);
    return [allPhotos count];
}

-(void)reloadUIAfterImageDownload
{
    NSLog(@"Delegate Reload Called.....\n");
    //[self.collectionView reloadData];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    /*DetailViewController is destination*/
    DetailViewController *detailView = [[DetailViewController alloc]init];
    PhotoCell *cell = [[PhotoCell alloc]init];
    
    if([segue.identifier isEqualToString:@"showFullPhoto"]) {
        detailView = segue.destinationViewController;
        
        /*index of image in collection view*/
        NSIndexPath *index = [[NSIndexPath alloc]init];
        index = [self.collectionView indexPathForCell:sender];
        
        cell = (PhotoCell *)[self.collectionView cellForItemAtIndexPath:index];
        
        detailView.theImage = cell.imageView.image;
        
        //detailView.theImageTitle =
        
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
