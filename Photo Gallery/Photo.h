//
//  Photo.h
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Photo : NSObject

@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSURL *imageURL;
@property(nonatomic, copy) UIImage *image;

-(id)initWithTitle:(NSString *)title AndImageURL:(NSURL *)imageURL AndUIImage:(UIImage *)image;

-(id)initImgurWithDictionary:(NSDictionary *)photo;
-(id)initFlickrWithDictionary:(NSDictionary *)photo;

@end
