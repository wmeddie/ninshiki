/*
 AssTrackerAppDelegate.m
 
 AssTracker A program to remind you when you've been working to long.
 Copyright (C) 2011 Eduardo Gonzalez
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#import "AssTrackerAppDelegate.h"

int64_t SystemIdleTime();

@implementation AssTrackerAppDelegate

@synthesize statusItem = statusItem_;
@synthesize statusMenu = statusMenu_;
@synthesize timer = timer_;
@synthesize minutes = minutes_;
@synthesize notifySound = notifySound_;

+ (void)initialize {
    NSDictionary *defaults = 
        [NSDictionary dictionaryWithObjectsAndKeys:
            [NSNumber numberWithInt:5], kIdleTimeDefaultKey, 
            [NSNumber numberWithInt:60], kNotifyTimeDefaultKey,
            [NSNumber numberWithInt:1], kPlayAtStartDefaultKey,
            @"", kSoundFilePathDefaultKey, nil];
    
    [[NSUserDefaults standardUserDefaults]  registerDefaults:defaults];
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    self.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSVariableStatusItemLength];
    [self.statusItem setMenu:self.statusMenu];
    [self.statusItem setHighlightMode:YES];
    
    [self updateStatusItem];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *soundFilePath = [defaults objectForKey:kSoundFilePathDefaultKey];
    bool playAtStart = [defaults boolForKey:kPlayAtStartDefaultKey];
    
    if ((soundFilePath != nil) && ![soundFilePath isEqualToString:@""]) {
        self.notifySound = [[NSSound alloc] initWithContentsOfFile:soundFilePath
                                                       byReference:NO];
    }
    
    if (self.notifySound == nil) {
        self.notifySound = 
            [[NSSound alloc] initWithContentsOfFile:[[NSBundle mainBundle] 
                                                     pathForSoundResource:@"bowl.wav"] 
                                        byReference:NO];
    }
    
    if (playAtStart == true) {
        [self.notifySound play];
    }
    
    self.timer = [NSTimer timerWithTimeInterval:60
                                         target:self
                                       selector:@selector(updateTimer:) 
                                       userInfo:nil 
                                        repeats:YES];

    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSDefaultRunLoopMode];
}

- (void)updateStatusItem {
    if (self.minutes < 60) {
        [self.statusItem setTitle:[NSString stringWithFormat:@"%dm", 
                                   (int)self.minutes]];
    } else {
        [self.statusItem setTitle:[NSString stringWithFormat:@"%dh %dm", 
                                   (int)(self.minutes / 60), (int)(self.minutes % 60)]];
    }
}

- (IBAction)showPreferences:(id)sender {
    PreferencesWindowController *prefs = 
        [PreferencesWindowController sharedPreferences];
    
    [prefs showWindow:self];
    [prefs.window makeKeyAndOrderFront:self];
    prefs.window.level = NSPopUpMenuWindowLevel;

    [[NSApplication sharedApplication] runModalForWindow:prefs.window];
}

- (IBAction)showAbout:(id)sender {
    AboutWindowController *about = [AboutWindowController sharedAbout];
    
    [about showWindow:self];
    [about.window makeKeyAndOrderFront:self];
    about.window.level = NSPopUpMenuWindowLevel;
    
    [[NSApplication sharedApplication] runModalForWindow:about.window];
}

- (IBAction)quit:(id)sender {
    [[NSApplication sharedApplication] terminate:self];
}

- (void)updateTimer:(NSTimer *)timer {
    int64_t idlesecs = SystemIdleTime();
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int idleTime = [[defaults objectForKey:kIdleTimeDefaultKey] intValue];
    int ringTime = [[defaults objectForKey:kNotifyTimeDefaultKey] intValue];
    
    if (idlesecs < (idleTime * 60)) {
        self.minutes += 1;
    
        if ((self.minutes % ringTime) == 0) {
            [self.notifySound play];
        }

    } else {
        self.minutes = 0;
    }
    
    [self updateStatusItem];
}

/**
 Returns the number of seconds the machine has been idle or -1 if an error occurs.
 The code is compatible with Tiger/10.4 and later (but not iOS).
 */
int64_t SystemIdleTime() {
    int64_t idlesecs = -1;
    io_iterator_t iter = 0;
    if (IOServiceGetMatchingServices(kIOMasterPortDefault, IOServiceMatching("IOHIDSystem"), &iter) == KERN_SUCCESS) {
        io_registry_entry_t entry = IOIteratorNext(iter);
        if (entry)  {
            CFMutableDictionaryRef dict = NULL;
            if (IORegistryEntryCreateCFProperties(entry, &dict, kCFAllocatorDefault, 0) == KERN_SUCCESS) {
                CFNumberRef obj = (CFNumberRef) CFDictionaryGetValue(dict, CFSTR("HIDIdleTime"));
                if (obj) {
                    int64_t nanoseconds = 0;
                    if (CFNumberGetValue(obj, kCFNumberSInt64Type, &nanoseconds)) {
                        idlesecs = (nanoseconds / 1000000000); // Convert from nanoseconds to seconds.
                    }
                }
                CFRelease(dict);
            }
            IOObjectRelease(entry);
        }
        IOObjectRelease(iter);
    }
    return idlesecs;
}

@end
