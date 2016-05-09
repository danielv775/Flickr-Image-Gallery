//
//  ViewFullSizeImage.m
//  PhotoGallery
//
//  Created by Dan Vasilyonok on 5/7/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import "ViewFullSizeImage.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewFullSizeImage ()

@end

@implementation ViewFullSizeImage

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initUI];
    
    self.imageView.image = self.theImage;
    //NSLog(@"titleImage: %@", self.theImageTitle);
    self.imageTitleLabel.text = self.theImageTitle;
}

-(void)initUI
{
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [self.imageView.layer setBorderWidth: 2.0];
    //self.imageView.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:235/255.0 alpha:0.75];
    self.imageView.backgroundColor = [UIColor lightGrayColor];
}

-(void)viewWillAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelBtn:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)viewImageMetaData
{
    NSData *imageData = UIImageJPEGRepresentation(self.theImage,1.0);
    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)imageData, nil);
    NSDictionary *metaData = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source, 0, nil));
    
    [metaData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"The key is: %@", key);
        NSLog(@"The value is: %@", obj);
    }];
}

@end
