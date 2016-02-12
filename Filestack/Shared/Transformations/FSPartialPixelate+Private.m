//
//  FSPartialPixelate+Private.m
//  Filestack
//
//  Created by Łukasz Cichecki on 10/02/16.
//  Copyright © 2016 Filestack. All rights reserved.
//

#import "FSPartialPixelate+Private.h"

@implementation FSPartialPixelate (Private)

- (NSString *)toQuery {
    if (!self.objects.firstObject) {
        return nil;
    }

    NSMutableArray *queryArray = [[NSMutableArray alloc] init];

    [queryArray addObject:[self objectsArrayToString]];

    if (self.buffer) {
        [queryArray addObject:[NSString stringWithFormat:@"buffer:%ld", (long)[self.buffer integerValue]]];
    }

    if (self.amount) {
        [queryArray addObject:[NSString stringWithFormat:@"amount:%ld", (long)[self.amount integerValue]]];
    }

    if (self.blur) {
        [queryArray addObject:[NSString stringWithFormat:@"blur:%f", [self.blur floatValue]]];
    }

    if (self.type) {
        [queryArray addObject:[NSString stringWithFormat:@"type:%@", self.type]];
    }

    return [NSString stringWithFormat:@"%@=%@", @"partial_pixelate", [queryArray componentsJoinedByString:@","]];
}

- (NSString *)objectsArrayToString {
    NSMutableArray *objectsString = [[NSMutableArray alloc] init];

    for (NSArray *object in self.objects) {
        [objectsString addObject:[NSString stringWithFormat:@"[%@]", [object componentsJoinedByString:@","]]];
    }

    return [objectsString componentsJoinedByString:@","];
}

@end