#import "XMPP.h"
#import "XMPPLogging.h"
#import "XMPPServiceDiscover.h"
#import "NSNumber+XMPP.h"
#import "XMPPIDTracker.h"

// Log levels: off, error, warn, info, verbose
// Log flags: trace
#ifdef DEBUG
  static const int xmppLogLevel = XMPP_LOG_LEVEL_VERBOSE; // | XMPP_LOG_FLAG_TRACE;
#else
  static const int xmppLogLevel = XMPP_LOG_LEVEL_WARN;
#endif

#define XMLNS_DISCO_ITEMS  @"http://jabber.org/protocol/disco#items"

enum XMPPServiceDiscoverFlags
{
	kRequestedRoster = 1 << 0,  // If set, we have requested the roster
};

@implementation XMPPServiceDiscover

@dynamic autoFetchMyServerConference;
- (BOOL)autoFetchMyServerConference
{
	__block BOOL result = NO;
	
	dispatch_block_t block = ^{
		result = autoFetchMyServerConference;
	};
	
	if (dispatch_get_specific(moduleQueueTag))
		block();
	else
		dispatch_sync(moduleQueue, block);
	
	return result;
}

- (void)setAutoFetchMyServerConference:(BOOL)flag
{
	dispatch_block_t block = ^{
		autoFetchMyServerConference = flag;
	};
	
	if (dispatch_get_specific(moduleQueueTag))
		block();
	else
		dispatch_async(moduleQueue, block);
}


- (id)init
{
	return [self initWithChatRoomStorage:nil dispatchQueue:NULL];
}

- (id)initWithDispatchQueue:(dispatch_queue_t)queue
{
	return [self initWithChatRoomStorage:nil dispatchQueue:queue];
}

- (id)initWithChatRoomStorage:(id <XMPPServiceDiscoverStorage>)storage
{
	return [self initWithChatRoomStorage:storage dispatchQueue:NULL];
}

- (id)initWithChatRoomStorage:(id <XMPPServiceDiscoverStorage>)storage dispatchQueue:(dispatch_queue_t)queue
{
	NSParameterAssert(storage != nil);
	
	if ((self = [super initWithDispatchQueue:queue]))
	{
		if ([storage configureWithParent:self queue:moduleQueue])
		{
			xmppDiscoverStorage = storage;
		}
		else
		{
			XMPPLogError(@"%@: %@ - Unable to configure storage!", THIS_FILE, THIS_METHOD);
		}
	}
	return self;
}


- (BOOL)activate:(XMPPStream *)aXmppStream
{
	XMPPLogTrace();
	
	if ([super activate:aXmppStream])
	{
        XMPPLogVerbose(@"%@: Activated", THIS_FILE);
        
		return YES;
	}
	
	return NO;
}

- (void)deactivate
{
	XMPPLogTrace();
    
    dispatch_block_t block = ^{ @autoreleasepool {
        
	}};
    
	if (dispatch_get_specific(moduleQueueTag))
		block();
	else
		dispatch_sync(moduleQueue, block);
	
	
	[super deactivate];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark XMPPStream Delegate
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

- (void)xmppStreamDidAuthenticate:(XMPPStream *)sender
{
	// This method is invoked on the moduleQueue.
	
	XMPPLogTrace();
    if (autoFetchMyServerConference) {
		XMPPJID *myJID = [xmppStream myJID];
        XMPPJID *myServerJID = [XMPPJID jidWithUser:nil domain:[NSString stringWithFormat:@"%@.%@",@"conference",[myJID domain]] resource:nil];
        [self fetchConference:myServerJID];
    }
}

- (BOOL)xmppStream:(XMPPStream *)sender didReceiveIQ:(XMPPIQ *)iq
{
	// This method is invoked on the moduleQueue.
	
	XMPPLogTrace();
	
	// Note: Some jabber servers send an iq element with an xmlns.
	// Because of the bug in Apple's NSXML (documented in our elementForName method),
	// it is important we specify the xmlns for the query.
	
	NSXMLElement *query = [iq elementForName:@"query" xmlns:XMLNS_DISCO_ITEMS];;
	
    if (query) {
        NSArray *items = [query elementsForName:@"item"];
        [self _addChatRooms:items];
    }
	
	return NO;
}

- (void)xmppStream:(XMPPStream *)sender didReceivePresence:(XMPPPresence *)presence
{
	// This method is invoked on the moduleQueue.
	XMPPLogTrace();
	
}

- (void)xmppStream:(XMPPStream *)sender didSendPresence:(XMPPPresence *)presence
{
	// This method is invoked on the moduleQueue.
	
	XMPPLogTrace();
	
}

- (void)xmppStreamDidDisconnect:(XMPPStream *)sender withError:(NSError *)error
{
	// This method is invoked on the moduleQueue.
	
	XMPPLogTrace();
}

- (void)_addChatRooms:(NSArray *)rosterItems
{
    NSAssert(dispatch_get_specific(moduleQueueTag) , @"Invoked on incorrect queue");
    
//    BOOL hasRoster = [self hasRoster];
    
    for (NSXMLElement *item in rosterItems)
    {
        // During roster population, we need to filter out items for users who aren't actually in our roster.
        // That is, those users who have requested to be our buddy, but we haven't approved yet.
        // This is described in more detail in the method isRosterItem above.
        
//        [multicastDelegate xmppRoster:self didReceiveRosterItem:item];
        
//        if (hasRoster || [self isRosterItem:item])
//        {
            [xmppDiscoverStorage handleChatRoomItem:item xmppStream:xmppStream];
//        }
    }
}

-(void)fetchConference:(XMPPJID*)jid
{
    dispatch_block_t block = ^{ @autoreleasepool {
        NSXMLElement *query = [NSXMLElement elementWithName:@"query" xmlns:XMLNS_DISCO_ITEMS];
        
        
        XMPPIQ *iq = [XMPPIQ iqWithType:@"get" to:jid elementID:[xmppStream generateUUID] child:query];
        
        [xmppStream sendElement:iq];
	}};
	
	if (dispatch_get_specific(moduleQueueTag))
		block();
	else
		dispatch_async(moduleQueue, block);
}

@end
