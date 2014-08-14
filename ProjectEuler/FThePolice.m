//
//  FThePolice.m
//  ProjectEuler
//
//  Created by Ken Ferry on 8/7/14.
//  Copyright (c) 2014 Understudy. All rights reserved.
//

#import "FThePolice.h"
#import <objc/message.h>


@implementation FThePolice
+ (NSInteger)sendProblemMessage:(SEL)probSelector toObject:(id)obj {
    NSInteger (*typedObjCMsgSend)(id obj, SEL cmd) = (void*)objc_msgSend;
    return typedObjCMsgSend(obj, probSelector);
}
@end
