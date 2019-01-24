//
//  Photo.m
//  Cats
//
//  Created by jason harrison on 2019-01-24.
//  Copyright © 2019 jason harrison. All rights reserved.
//

#import "Photo.h"

@implementation Photo

/*
 @property (nonatomic, strong, readonly) NSString *id;
 @property (nonatomic, strong, readonly) NSString *owner;
 @property (nonatomic, strong, readonly) NSString *secret;
 @property (nonatomic, strong, readonly) NSString *server;
 @property (nonatomic, readonly) int farm;
 @property (nonatomic, strong, readonly) NSString *title;
 @property (nonatomic, readonly) BOOL isPublic;
 @property (nonatomic, readonly) BOOL isFriend;
 @property (nonatomic, readonly) BOOL isFamily;
 
 */

- (instancetype)initWithId:(NSString *)photoId
                  andOwner:(NSString *)owner
                 andSecret:(NSString *)secret
                 andServer:(NSString *)server
                   andFarm:(int)farm
                  andTitle:(NSString *)title
               andIsPublic:(BOOL)isPublic
               andIsFriend:(BOOL)isFriend
               andIsFamily:(BOOL)isFamily
{
    self = [super init];
    if (self) {
        _photoId = photoId;
        _owner = owner;
        _secret = secret;
        _server = server;
        _farm = farm;
        _title = title;
        _isPublic = isPublic;
        _isFriend = isFriend;
        _isFamily = isFamily;
        
        
        // build URL string
        
        NSMutableString *urlString = [[NSMutableString alloc] initWithString:@"https://farm"];
        [urlString appendString:[NSString stringWithFormat:@"%d" , _farm]];
        [urlString appendString:@".staticflickr.com/"];
        [urlString appendString:_server];
        [urlString appendString:@"/"];
        [urlString appendString:_photoId];
        [urlString appendString: @"_"];
        [urlString appendString: _secret];
        [urlString appendString: @".jpg"];
        
        
         _url = urlString;
        
      //  NSLog(@"url is %@", _url);
         //https://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
        // https://farm5.staticflickr.com/4916/31919761287_72fbc8c25f.jpg
        // {"id":"31919761287","owner":"73299437@N00","secret":"72fbc8c25f","server":"4916","farm":5,"title":"Charly :(","ispublic":1,"isfriend":0,"isfamily":0},
        
    }
    return self;
}

@end
