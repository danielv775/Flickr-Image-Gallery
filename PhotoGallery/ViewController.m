//
//  ViewController.m
//  PhotoGallery
//
//  Created by Dan Vasilyonok on 5/7/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import "ViewController.h"
#import "CustomFlowLayout.h"
#import "ViewFullSizeImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
        
    [super viewDidLoad];
    
    self.collectionView.collectionViewLayout = [[CustomFlowLayout alloc] init];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}

/*
-(void)viewWillAppear:(BOOL)animated
{
    //[self changeNavBarAttributes];
    //self.loadCount = 0;
}
 */


-(void)viewDidAppear:(BOOL)animated
{
    self.flickrAPI = [[ImageLibrary alloc]init];
    [self.flickrAPI initImageArrays];
    [self.flickrAPI loadFlickrPhotosAndSearch:@"beach" AndReload:self.collectionView];
    
    [self changeNavBarAttributes];
}

#pragma mark - collectionView methods
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"photoCell" forIndexPath:indexPath];
    
    /*Fix scrolling lag?..not working atm*/
    self.cell.layer.shouldRasterize = YES;
    self.cell.layer.rasterizationScale = [UIScreen mainScreen].scale;
    
    //NSString *imageName = [[NSString alloc]init];
    
    /*assign image to photoCell in collection view*/
    NSData *imageDataDisplay = [NSData dataWithContentsOfURL:[self.photoURLsLarge objectAtIndex:indexPath.row]];
    self.cell.imageView.image = [UIImage imageWithData:imageDataDisplay];
    
    /*
    NSLog(@"Filling the collectionview...%i\n", self.loadCount);
    if(indexPath.row % 3 == 0) {
        imageName = @"image3";
    }
    else if(indexPath.row % 3 == 1) {
        imageName = @"image4";
    }
    else if(indexPath.row % 3 == 2) {
        imageName = @"image5";
    }
     
    
    self.cell.imageView.image = [UIImage imageNamed:imageName];
     */
    
    
    return self.cell;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //populate array with images after 1 reload, i.e images have finished downloading
    [self populateLocalArrays];
    //[self debugArrays];
    return [self.photoNames count];
}

-(void)populateLocalArrays
{
    self.photoNames = self.flickrAPI.photoNames;
    self.imageData = self.flickrAPI.imageData;
    self.photoURLsLarge = self.flickrAPI.photoURLsLarge;
}

-(void)debugArrays
{
    NSLog(@"Number of Photos in imageTitles: %lu", [self.photoNames count]);
    NSLog(@"Number of Photos in imageDataSmall: %lu", [self.imageData count]);
    NSLog(@"Number of Photos in imageDataLarge: %lu", [self.photoURLsLarge count]);
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    ViewFullSizeImage *controller = [[ViewFullSizeImage alloc]init];
    ViewPhotoCell *imageCell = [[ViewPhotoCell alloc]init];
    
    if([segue.identifier isEqualToString:@"showFullPhoto"]) {
        controller = segue.destinationViewController;
        
        //index of image in the collectionview
        NSIndexPath *index = [[NSIndexPath alloc]init];
        index = [self.collectionView indexPathForCell:sender];
        
        imageCell = (ViewPhotoCell*)[self.collectionView cellForItemAtIndexPath:index];
        
        //pass the image from the selected cell to the "theImage" UIImage
        controller.theImage = imageCell.imageView.image;
        //pass image title from selected cell to the "theImageTitle" NSString
        controller.theImageTitle = self.photoNames[index.item];
            
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
