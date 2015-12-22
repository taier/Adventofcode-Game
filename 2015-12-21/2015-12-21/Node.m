//
//  Node.m
//  2015-12-21
//
//  Created by Deniss Kaibagarovs on 21/12/15.
//  Copyright © 2015 Deniss Kaibagarovs. All rights reserved.
//

#import "Node.h"

@implementation Node

- (instancetype)init {
    self = [super init];
    if (self) {
        self.right = NULL;
        self.left = NULL;
        self.up  = NULL;
        self.down = NULL;
        self.presentsCount = 0;
    }
    
    return  self;
}

@end
