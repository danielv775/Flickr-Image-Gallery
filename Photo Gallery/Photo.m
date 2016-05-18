//
//  Photo.m
//  Photo Gallery
//
//  Created by Dan Vasilyonok on 5/13/16.
//  Copyright © 2016 Dan Vasilyonok. All rights reserved.
//

#import "Photo.h"

@implementation Photo

-(id)initWithTitle:(NSString *)title AndImageURL:(NSURL *)imageURL AndUIImage:(UIImage*)image {
    self = [super init];
    if(self) {
        self.title = title;
        self.imageURL = imageURL;
        self.image = image;
    }
    return self;
}

-(id)initImgurWithDictionary:(NSDictionary *)photo {
    self = [super init];
    if(self) {
        self.title = [photo objectForKey:@"title"];
        self.imageURL = [NSURL URLWithString: [photo objectForKey:@"link"]];
        
        NSLog(@"Imgur: title: %@ and URL: %@\n\n", self.title, self.imageURL);
        
    }
    return self;
}

-(id)initFlickrWithDictionary:(NSDictionary *)photo {
    self = [super init];
    if(self) {
        self.title = [photo objectForKey:@"title"];
        
        NSString *photoURLString =
        [NSString stringWithFormat:@"https://farm%@.static.flickr.com/%@/%@_%@_m.jpg",
         [photo objectForKey:@"farm"], [photo objectForKey:@"server"],
         [photo objectForKey:@"id"], [photo objectForKey:@"secret"]];
        
        NSLog(@"Flickr: title: %@ and URL: %@\n\n", self.title, photoURLString);
        
        /*GET imageURL for photo model*/
        self.imageURL = [NSURL URLWithString:photoURLString];
       
    }
    return self;
}


@end
