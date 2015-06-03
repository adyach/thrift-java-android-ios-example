//
//  ViewController.m
//  ThriftExample
//
//  Created by Vladimir Khramtsov on 03.06.15.
//  Copyright (c) 2015 Vladimir Khramtsov. All rights reserved.
//

#import "ViewController.h"
#import "VKService.h"
#import "MessagingService.h"

static NSString *const kCredentialsToken = @"demo";
static CGFloat const kTargetUserId = 42;

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *messageTextField;
@property (weak, nonatomic) IBOutlet UITextView *logTextView;

@property (strong, nonatomic) UserCredentials *credentials;

@end

@implementation ViewController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.credentials = [[UserCredentials alloc] initWithToken:kCredentialsToken];
}

#pragma mark - IBActions

- (IBAction)sendButtonPressed:(id)sender {
    NewMessage *message = [[NewMessage alloc] initWithSender:self.credentials
                                                        body:self.messageTextField.text
                                                targetUserId:kTargetUserId];
    if ([[VKService sharedService] postMessage:message]) {
        [self addLog:@"successfully posted message!"];
    } else {
        [self addLog:@"failed to post message!"];
    }
    
}

- (IBAction)pingButtonPressed:(id)sender {
    [[VKService sharedService] ping:self.credentials];
    [self addLog:@"pinged"];
}

- (IBAction)fetchMessagesButtonPressed:(id)sender {
    NSMutableArray *messages = [[VKService sharedService] fetchMessages:self.credentials];
    for (Message *message in messages) {
        NSString *description = [NSString stringWithFormat:@"%i %@ %i %@",
                                 message.sender.id,
                                 message.sender.name,
                                 message.timestamp,
                                 message.body];
        [self addLog:description];
    }
}

#pragma mark - Helpers

- (void)addLog:(NSString *)log {
    log = [log stringByAppendingString:@"\n"];
    self.logTextView.text = [self.logTextView.text stringByAppendingString:log];
}

@end
