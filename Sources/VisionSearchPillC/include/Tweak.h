#import <UIKit/UIKit.h>
#import <SpringBoard/SpringBoard.h>
#import <RemoteLog.h>

@interface SBHSearchPillView : UIView
@property (nonatomic, strong, readwrite) UIView *backgroundView;
- (void)applyVisionStyle;
- (void)testNotification;
@end

@interface SBFolderScrollAccessoryView : UIView
@property (nonatomic, strong, readwrite) UIView *backgroundView;
- (void)applyVisionStyle;
@end

NS_SWIFT_NAME(DistributedNotificationCenter)
@interface NSDistributedNotificationCenter : NSNotificationCenter
+ (instancetype)defaultCenter;
- (void)postNotificationName:(NSNotificationName)name object:(NSString *)object userInfo:(NSDictionary *)userInfo deliverImmediately:(BOOL)deliverImmediately;
@end