//
//  ViewFullSizeImage.h
//  PhotoGallery
//
//  Created by Dan Vasilyonok on 5/7/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ImageIO/ImageIO.h>

@interface ViewFullSizeImage : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *imageTitleLabel;

@property(strong, nonatomic) UIImage *theImage;
@property(atomic) NSString *theImageTitle;
//@property (weak, nonatomic) IBOutlet UIView *metaView;

- (IBAction)cancelBtn:(id)sender;

@end
