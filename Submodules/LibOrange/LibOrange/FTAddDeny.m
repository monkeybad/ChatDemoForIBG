//
//  FTAddDeny.m
//  LibOrange
//
//  Created by Alex Nichol on 6/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FTAddDeny.h"


@implementation FTAddDeny

- (id)initWithUsername:(NSString *)username {
	if ((self = [super init])) {
		denyUsername = [username retain];
	}
	return self;
}

- (void)createOperationsWithFeedbag:(AIMFeedbag *)feedbag session:(AIMSession *)session {
	// check if the feedbag already has the denied user.
	AIMFeedbagItem * existing = [feedbag denyWithUsername:denyUsername];
	if (existing) {
		snacs = [[NSArray alloc] init];
		snacIndex = -1;
		return;
	} else {
		AIMFeedbagItem * newItem = [[AIMFeedbagItem alloc] init];
		newItem.attributes = [NSMutableArray array];
		newItem.classID = FEEDBAG_DENY;
		newItem.itemID = [feedbag randomItemID];
		newItem.groupID = 0;
		newItem.itemName = denyUsername;
		SNAC * insert = [[SNAC alloc] initWithID:SNAC_ID_NEW(SNAC_FEEDBAG, FEEDBAG__INSERT_ITEMS) flags:0 requestID:[session generateReqID] data:[newItem encodePacket]];
		[newItem release];
		snacs = [[NSArray alloc] initWithObjects:insert, nil];
		[insert release];
		snacIndex = -1;
	}
}

- (BOOL)hasCreatedOperations {
	if (snacs) return YES;
	else return NO;
}

- (SNAC *)nextTransactionSNAC {
	if (snacIndex + 1 == [snacs count]) return nil;
	return [snacs objectAtIndex:++snacIndex];
}

- (SNAC *)currentTransactionSNAC {
	if (snacIndex < 0) return nil;
	return [snacs objectAtIndex:snacIndex];
}

- (void)dealloc {
	[snacs release];
	[denyUsername release];
	[super dealloc];
}

@end
