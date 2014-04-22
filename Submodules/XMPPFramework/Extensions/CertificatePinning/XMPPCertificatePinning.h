//
//  XMPPCertificatePinning.h
//  Off the Record
//
//  Created by David on 9/17/13.
//  Copyright (c) 2013 Chris Ballinger. All rights reserved.
//

#import "XMPPModule.h"

@class AFSecurityPolicy;

@interface XMPPCertificatePinning : XMPPModule

@property (nonatomic,strong) AFSecurityPolicy * securityPolicy;

- (id)initWithCertificates:(NSArray *)certificates;
- (id)initWithDefaultCertificates;

+ (id)defaultCertificates;

@end
