#include <notify.h>
#define prefpath @"/var/mobile/Library/Preferences/ws.hbang.notitoggle.plist"

extern "C" BOOL isCapable() {
	return YES;
}
extern "C" BOOL isEnabled() {
	if (![[NSFileManager defaultManager] fileExistsAtPath:prefpath]) {
		return YES;
	}
	NSDictionary *prefs = [NSDictionary dictionaryWithContentsOfFile:prefpath];
	return [prefs objectForKey:@"Enabled"] ? [[prefs objectForKey:@"Enabled"] boolValue] : YES;
}
extern "C" void setState(BOOL enabled) {
	NSMutableDictionary *prefs = [NSMutableDictionary dictionaryWithContentsOfFile:prefpath];
	[prefs setObject:[NSNumber numberWithBool:enabled] forKey:@"Enabled"];
	[prefs writeToFile:prefpath atomically:YES];
	notify_post("ws.hbang.notitoggle/ReloadPrefs");
}
extern "C" float getDelayTime() {
	return 0;
}
