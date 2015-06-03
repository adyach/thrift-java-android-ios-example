//
//  VKService.h
//  ThriftExample
//
//  Created by Vladimir Khramtsov on 03.06.15.
//  Copyright (c) 2015 Vladimir Khramtsov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MessagingService.h"

@interface VKService : NSObject <Messaging>

+ (instancetype)sharedService;

@end
