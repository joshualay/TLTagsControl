//
//  ViewController.m
//  TagsInputSample
//
//  Created by Антон Кузнецов on 11.02.15.
//  Copyright (c) 2015 TheLightPrjg. All rights reserved.
//

#import "ViewController.h"
#import "TLTagsControl.h"
@interface ViewController ()<TLTagsControlListDelegate, TLTagsControlEditDelegate, UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet TLTagsControl *defaultEditingTagControl;
@property (nonatomic, weak) IBOutlet TLTagsControl *defaultListingTagControl;
@property (nonatomic, weak) IBOutlet TLTagsControl *defaultExteralInputTagControl;
@property (nonatomic, weak) IBOutlet UITextField* tagTextField;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSString *(^lowerCaseFormatter)(NSString* text) = ^NSString* (NSString* text) {
        return [text lowercaseString];
    };
    // Do any additional setup after loading the view, typically from a nib.
    NSMutableArray *tags = [NSMutableArray arrayWithArray:@[@"A", @"Tag", @"One", @"More", @"Tag", @"And", @"Yet", @"Another", @"One"]];
    _defaultEditingTagControl.tags = [tags mutableCopy];
    _defaultEditingTagControl.tagPlaceholder = @"Placeholder";
    _defaultEditingTagControl.editDelegate = self;
    _defaultEditingTagControl.textInputFormatter = lowerCaseFormatter;

    _defaultListingTagControl.tags = [tags mutableCopy];
    _defaultListingTagControl.mode = TLTagsControlModeList;
    _defaultListingTagControl.listDelegate = self;

    _defaultExteralInputTagControl.editDelegate = self;
    _defaultExteralInputTagControl.mode = TLTagsControlModeExternalInput;
    _defaultExteralInputTagControl.textInputFormatter = lowerCaseFormatter;

    [_defaultEditingTagControl reloadTagSubviews];
    [_defaultListingTagControl reloadTagSubviews];
    [_defaultExteralInputTagControl reloadTagSubviews];
}

#pragma mark - TLTagsControlListDelegate
- (void)tagsControl:(TLTagsControl *)tagsControl tappedAtIndex:(NSInteger)index {
    NSLog(@"Tag \"%@\" was tapped", tagsControl.tags[index]);
}

#pragma mark - TLTagsControlEditDelegate
- (void)tagsControl:(TLTagsControl *)tagsControl didAddTag:(NSString *)tag {
    NSLog(@"Added tag \"%@\"", tag);
}

- (void)tagsControl:(TLTagsControl *)tagsControl didDeleteTag:(NSString *)tag {
    NSLog(@"Deleted tag \"%@\"", tag);
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length > 0) {
        [_defaultExteralInputTagControl addTag:textField.text];

        textField.text = @"";
    }

    return YES;
}
@end
