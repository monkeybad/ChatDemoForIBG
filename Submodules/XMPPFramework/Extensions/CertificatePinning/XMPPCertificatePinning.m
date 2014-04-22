//
//  XMPPCertificatePinning.m
//  Off the Record
//
//  Created by David on 9/17/13.
//  Copyright (c) 2013 Chris Ballinger. All rights reserved.
//

#import "XMPPCertificatePinning.h"
#import "XMPPStream.h"
#import "AFSecurityPolicy.h"

@implementation XMPPCertificatePinning

@synthesize securityPolicy;

- (id)initWithCertificates:(NSArray *)certificates
{
    if (self = [super init]) {
        self.securityPolicy = [[AFSecurityPolicy alloc] init];
        self.securityPolicy.pinnedCertificates = certificates;
        self.securityPolicy.SSLPinningMode= AFSSLPinningModePublicKey;
    }
    return self;
}
- (id)initWithDefaultCertificates
{
    if (self = [super init]) {
        securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    }
    return self;
    
}

+ (id)defaultCertificates
{
    XMPPCertificatePinning * certPinning = [[self alloc] initWithDefaultCertificates];
    return certPinning;
}
/**
 *For simulator use and collecting certs in documents folder then moved to App Bundle
 **/
-(void)writeCertToDisk:(SecTrustRef)trust withFileName:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0] : nil;
    if (basePath) {
        NSString * path = [NSString pathWithComponents:@[basePath,fileName]];
        CFIndex certificateCount = SecTrustGetCertificateCount(trust);
        if (certificateCount) {
            SecCertificateRef certificate = SecTrustGetCertificateAtIndex(trust, 0);
            NSData * data = (__bridge_transfer NSData *)SecCertificateCopyData(certificate);
            [data writeToFile:path atomically:YES];
        }
    }
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark XMPPStreamDeleage
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)socket:(GCDAsyncSocket *)sock shouldTrustPeer:(SecTrustRef)trust
{
    //[self writeCertToDisk:trust withFileName:@"google.cer"];
    BOOL trusted = [securityPolicy evaluateServerTrust:trust];
    return trusted;
}




@end
