//
//  DetailViewController.h
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Photo.h"

@interface DetailViewController : UIViewController

/*Image View and Image Title Label*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *imageTitleLabel;

/*Back Button*/
- (IBAction)cancelBtn:(id)sender;

@property(strong, nonatomic) Photo *displayPhoto;

@end
