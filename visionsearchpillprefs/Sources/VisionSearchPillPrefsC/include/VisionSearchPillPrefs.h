#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>
#import <RemoteLog.h>

NS_SWIFT_NAME(DistributedNotificationCenter)
@interface NSDistributedNotificationCenter : NSNotificationCenter
+ (instancetype)defaultCenter;
- (void)postNotificationName:(NSNotificationName)name object:(NSString *)object userInfo:(NSDictionary *)userInfo deliverImmediately:(BOOL)deliverImmediately;
@end

@interface GcColorPickerCell : PSTableCell
- (void)colorPickerViewControllerDidFinish:(UIColorPickerViewController *)controller;
@end