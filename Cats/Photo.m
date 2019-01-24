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
    }
    return self;
}

@end
