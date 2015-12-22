//
//  Node.h
//  2015-12-21
//
//  Created by Deniss Kaibagarovs on 21/12/15.
//  Copyright © 2015 Deniss Kaibagarovs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Node : NSObject

@property (strong, nonatomic) Node *right;
@property (strong, nonatomic) Node *left;
@property (strong, nonatomic) Node *up;
@property (strong, nonatomic) Node *down;
@property (assign, nonatomic) int presentsCount;

@end
