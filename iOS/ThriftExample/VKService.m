//
//  VKService.m
//  ThriftExample
//
//  Created by Vladimir Khramtsov on 03.06.15.
//  Copyright (c) 2015 Vladimir Khramtsov. All rights reserved.
//

#import "VKService.h"
#import "TSocketClient.h"
#import "TBinaryProtocol.h"
#import "THTTPClient.h"

//NSString * const kServerUrl = @"http://10.0.2.2:8080/demo/";
NSString * const kServerUrl = @"http://localhost:8080/demo/";

@interface VKService()

@property (nonatomic, strong) THTTPClient *transport;
@property (nonatomic, strong) TBinaryProtocol *proto;
@property (nonatomic, strong) UserCredentials *credentials;
@property (nonatomic, strong) MessagingClient *client;

@end

@implementation VKService

#pragma mark - Init

+ (instancetype)sharedService {
    
    static VKService *_service = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _service = [[VKService alloc] init];
    });
    return _service;
}

- (instancetype)init {
    if (self = [super init]) {
        self.transport = [[THTTPClient alloc] initWithURL:[NSURL URLWithString:kServerUrl]];
        self.proto = [[TBinaryProtocol alloc] initWithTransport:self.transport strictRead:YES strictWrite:YES];
        self.client = [[MessagingClient alloc] initWithProtocol:self.proto];
    }
    return self;
}

#pragma mark - Services

- (void) ping: (UserCredentials *) credentials {
    @try {
        [self.client ping:credentials];
    }
    @catch (NSException *exception) {
    }
    @finally {
    }
}

- (BOOL)postMessage:(NewMessage *)message {
    @try {
        return [self.client postMessage:message];
    }
    @catch (NSException *exception) {
        return NO;
    }
    @finally {
    }
}

- (NSMutableArray *) fetchMessages: (UserCredentials *) credentials {
    @try {
        return [self.client fetchMessages:credentials];
    }
    @catch (NSException *exception) {
        return nil;
    }
    @finally {
    }
}

@end
