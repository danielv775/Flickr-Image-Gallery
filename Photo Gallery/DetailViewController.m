//
//  DetailViewController.m
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <ImageIO/ImageIO.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Use display photo object to extract image info
    
    [self initUI];
    
    [self.imageView sd_setImageWithURL:self.displayPhoto.imageURL placeholderImage:self.displayPhoto.image];
    //NSLog(@"image Title text: %@\n", self.theImageTitle);
    self.imageTitleLabel.text = self.displayPhoto.title;
    
    // Do any additional setup after loading the view.
}

-(void)initUI
{
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.imageView.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [self.imageView.layer setBorderWidth: 2.0];
    self.imageView.backgroundColor = [UIColor lightGrayColor];
}

- (IBAction)cancelBtn:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewImageMetaData
{
    NSData *imageData = UIImageJPEGRepresentation(self.displayPhoto.image,1.0);
    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef)imageData, nil);
    NSDictionary *metaData = (NSDictionary *)CFBridgingRelease(CGImageSourceCopyPropertiesAtIndex(source, 0, nil));
    
    [metaData enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSLog(@"The key is: %@", key);
        NSLog(@"The value is: %@", obj);
    }];
}


@end
