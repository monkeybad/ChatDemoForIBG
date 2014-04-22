//
//  UVPostIdeaViewController.h
//  UserVoice
//
//  Created by Austin Taylor on 10/23/13.
//  Copyright (c) 2013 UserVoice Inc. All rights reserved.
//

#import "UVBaseViewController.h"
#import "UVInstantAnswerManager.h"
#import "UVCallback.h"

@class UVTextView;

@interface UVPostIdeaViewController : UVBaseViewController<UVInstantAnswersDelegate, UITextViewDelegate> {
    UVCallback *_didCreateCallback;
    UVCallback *_didAuthenticateCallback;
    NSInteger _selectedCategoryId;
}

@property (nonatomic, retain) NSString *initialText;
@property (nonatomic, retain) UVInstantAnswerManager *instantAnswerManager;
@property (nonatomic, retain) UITextField *titleField;
@property (nonatomic, retain) NSLayoutConstraint *keyboardConstraint;
@property (nonatomic, retain) NSLayoutConstraint *topConstraint;
@property (nonatomic, retain) NSLayoutConstraint *descConstraint;
@property (nonatomic, retain) UILabel *desc;

@end
