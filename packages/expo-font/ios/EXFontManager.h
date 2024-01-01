// Copyright 2015-present 650 Industries. All rights reserved.

#import <Foundation/Foundation.h>
#import <ExpoFont/EXFont.h>

@interface EXFontManager : NSObject

- (instancetype)init;
- (EXFont *)fontForName:(NSString *)name;
- (void)setFont:(EXFont *)font forName:(NSString *)name;

@end
