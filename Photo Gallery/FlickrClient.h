//
//  FlickrClient.h
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

/*
 Although called FlickrClient, this API interfaces with both the Flickr API
 and Imgur API using GET requests to fetch images and populate the Photo Model
 */

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class FlickrClient;

@protocol FlickrClientDelegate <NSObject>

-(void)reloadUIAfterImageDownload;

@end

@interface FlickrClient : NSObject

//Used to communicate with VC, which should reload UI after images fetched from server
@property (weak, nonatomic) id <FlickrClientDelegate> delegate;

//GET used to retrieve data from flickr
-(id)getRequestFlickr:(NSString*)urlString;

//GET to retrieve data from imgur
-(id)getRequestImgur:(NSString*)urlString ImgurAPIKey:(NSString *)APIKey;

@end
