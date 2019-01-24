//
//  Photo.h
//  Cats
//
//  Created by jason harrison on 2019-01-24.
//  Copyright © 2019 jason harrison. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Photo : NSObject



@property (nonatomic, strong, readonly) NSString *photoId;
@property (nonatomic, strong, readonly) NSString *owner;
@property (nonatomic, strong, readonly) NSString *secret;
@property (nonatomic, strong, readonly) NSString *server;
@property (nonatomic, readonly) int farm;
@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, readonly) BOOL isPublic;
@property (nonatomic, readonly) BOOL isFriend;
@property (nonatomic, readonly) BOOL isFamily;
@property (nonatomic, strong, readonly) NSString *url;


- (instancetype)initWithId:(NSString *)photoId
                  andOwner:(NSString *)owner
                 andSecret:(NSString *)secret
                 andServer:(NSString *)server
                   andFarm:(int)farm
                  andTitle:(NSString *)title
               andIsPublic:(BOOL)isPublic
               andIsFriend:(BOOL)isFriend
               andIsFamily:(BOOL)isFamily;


@end

NS_ASSUME_NONNULL_END
