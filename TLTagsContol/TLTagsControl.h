//
//  TLTagsControl.h
//  TagsInputSample
//
//  Created by Антон Кузнецов on 11.02.15.
//  Copyright (c) 2015 TheLightPrjg. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TLTagsControl;

@protocol TLTagsControlListDelegate <NSObject>
- (void)tagsControl:(TLTagsControl *)tagsControl tappedAtIndex:(NSInteger)index;
@end

@protocol TLTagsControlEditDelegate <NSObject>
- (void)tagsControl:(TLTagsControl *)tagsControl didAddTag:(NSString*)tag;
- (void)tagsControl:(TLTagsControl *)tagsControl didDeleteTag:(NSString*)tag;
@end

typedef NS_ENUM(NSUInteger, TLTagsControlMode) {
    TLTagsControlModeEdit,
    TLTagsControlModeList,
    TLTagsControlModeExternalInput // Like TLTagsControlModeEdit except the text input is removed
};

@interface TLTagsControl : UIScrollView

@property (nonatomic, strong) NSMutableArray *tags;
@property (nonatomic, strong) UIColor *tagsBackgroundColor;
@property (nonatomic, strong) UIColor *tagsTextColor;
@property (nonatomic, strong) UIColor *tagsDeleteButtonColor;
@property (nonatomic, strong) NSString *tagPlaceholder;
// Keep the input text field as first responder after adding a tag
// Defaults to YES, only available in TLTagsControlModeEdit
@property (nonatomic, assign) BOOL keepTagInputAsFirstResponder;
@property (nonatomic) TLTagsControlMode mode;

@property (nonatomic, copy) NSString* (^textInputFormatter)(NSString* text);

@property (weak, nonatomic) id<TLTagsControlListDelegate> listDelegate;
@property (weak, nonatomic) id<TLTagsControlEditDelegate> editDelegate;

- (id)initWithFrame:(CGRect)frame andTags:(NSArray *)tags withTagsControlMode:(TLTagsControlMode)mode;

- (void)addTag:(NSString *)tag;
- (void)reloadTagSubviews;

@end