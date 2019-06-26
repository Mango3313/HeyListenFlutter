#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  [GMSServices provideAPIKey:@"AIzaSyBbCt1Q6RvEbOTkrhb4-HFpHVw2B2lzcrM"];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
