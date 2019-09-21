#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#include "GoogleMaps/GoogleMaps.h"
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  // [GMSServices provideAPIKey:@"AIzaSyCPjM5cEWp4KYYB11fMV76l1aWr9nsYQTg"];
  [GMSServices provideAPIKey:@"AIzaSyDPaFRwkTfLGUgDovW6ZrldT9e77mYR7sU"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  // Override point for customization after application launch.
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
