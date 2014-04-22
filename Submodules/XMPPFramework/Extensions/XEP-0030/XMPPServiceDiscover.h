#import <Foundation/Foundation.h>
#import "XMPPModule.h"

#if TARGET_OS_IPHONE
  #import "DDXML.h"
#endif

#define _XMPP_PRIVACY_H

@class XMPPIQ;
@class XMPPIDTracker;
@protocol XMPPServiceDiscoverStorage;

@interface XMPPServiceDiscover : XMPPModule
{
 	BOOL autoFetchMyServerConference;
	__strong id <XMPPServiceDiscoverStorage> xmppDiscoverStorage;
}

@property (assign) BOOL autoFetchMyServerConference;

- (id)initWithChatRoomStorage:(id <XMPPServiceDiscoverStorage>)storage;
- (id)initWithChatRoomStorage:(id <XMPPServiceDiscoverStorage>)storage dispatchQueue:(dispatch_queue_t)queue;

@end

@protocol XMPPServiceDiscoverStorage <NSObject>
- (void)handleChatRoomItem:(NSXMLElement *)item xmppStream:(XMPPStream *)stream;
- (BOOL)configureWithParent:(XMPPServiceDiscover *)aParent queue:(dispatch_queue_t)queue;
@end

