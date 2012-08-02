/**
 * NotiToggle
 *
 * By Ad@m <http://adam.hbang.ws>
 * Licensed under the MIT License <http://adam.mit-license.org>
 * Based on NotiQuiet (obviously :P)
 */

#define prefpath @"/var/mobile/Library/Preferences/ws.hbang.notitoggle.plist"

static BOOL enabled=YES;

%hook SBBulletinBannerController
-(void)observer:(id)observer addBulletin:(id)bulletin forFeed:(unsigned)feed{
	if(enabled)%orig;
}
%end

static void ADNTPrefsLoad(){
	if([[NSFileManager defaultManager]fileExistsAtPath:prefpath]){
		NSDictionary *prefs=[NSDictionary dictionaryWithContentsOfFile:prefpath];
		enabled=[prefs objectForKey:@"Enabled"]?[[prefs objectForKey:@"Enabled"]boolValue]:YES;
	}else{
		enabled=NO;
		NSDictionary *prefs=[NSDictionary dictionaryWithObject:[NSNumber numberWithBool:YES] forKey:@"Enabled"];
		[prefs writeToFile:prefpath atomically:YES];
	}
}
static void ADNTPrefsUpdate(CFNotificationCenterRef center,void *observer,CFStringRef name,const void *object,CFDictionaryRef userInfo){
	ADNTPrefsLoad();
}

%ctor{
	%init;
	ADNTPrefsLoad();
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),NULL,&ADNTPrefsUpdate,CFSTR("ws.hbang.notitoggle/ReloadPrefs"),NULL,0);
}
