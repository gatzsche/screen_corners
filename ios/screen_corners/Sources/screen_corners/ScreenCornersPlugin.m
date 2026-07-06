#import "ScreenCornersPlugin.h"
@import screen_corners_swift;

@implementation ScreenCornersPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftScreenCornersPlugin registerWithRegistrar:registrar];
}
@end
