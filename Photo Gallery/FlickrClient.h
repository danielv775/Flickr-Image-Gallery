//
//  FlickrClient.h
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FlickrClient;

@protocol FlickrClientDelegate <NSObject>

-(void)reloadUIAfterImageDownload;

@end

@interface FlickrClient : NSObject

//Used to communicate with VC, which should reload UI after images fetched from server
@property (weak, nonatomic) id <FlickrClientDelegate> delegate;

//GET used to retrieve remote data
- (id)getRequest:(NSString*)urlString;

//Retrieve downloaded photo from webserver
-(UIImage*)downloadImage:(NSURL*)url;

@end
