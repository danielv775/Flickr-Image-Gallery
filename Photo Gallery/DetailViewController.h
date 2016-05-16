//
//  DetailViewController.h
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

/*Image View and Image Title Label*/
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *imageTitleLabel;

/*Back Button*/
- (IBAction)cancelBtn:(id)sender;


/*pass image and title into these*/
@property(strong, nonatomic) UIImage *theImage;
@property(atomic) NSString *theImageTitle;

@end
