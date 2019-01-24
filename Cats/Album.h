//
//  Album.h
//  Cats
//
//  Created by jason harrison on 2019-01-24.
//  Copyright © 2019 jason harrison. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Photo.h"

NS_ASSUME_NONNULL_BEGIN

@interface Album : NSObject
@property (strong, nonatomic, readwrite) NSMutableArray<Photo *>*album;

- (void)addPhotoToAlbum:(Photo *)photo;

- (Photo *)getPhotoAtIndex:(int)index;

@end

NS_ASSUME_NONNULL_END
