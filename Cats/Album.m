//
//  Album.m
//  Cats
//
//  Created by jason harrison on 2019-01-24.
//  Copyright © 2019 jason harrison. All rights reserved.
//

#import "Album.h"

@implementation Album

- (instancetype)init
{
    self = [super init];
    if (self != nil) {
        _album = [[NSMutableArray<Photo *> alloc] init];
    }
    return self;
}

- (void)addPhotoToAlbum:(Photo *)photo{
    [self.album addObject:photo];
}

- (Photo *)getPhotoAtIndex:(int)index{
    return [self.album objectAtIndex:index];
}

@end
