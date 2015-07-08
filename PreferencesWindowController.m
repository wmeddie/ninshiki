/*
 PreferencesWindowController.m
 
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
//
//  PreferencesWindowController.m
//  AssTracker
//
//  Created by ゴンザレズ エドワルド on 4/27/11.
//  Copyright 2011 日本ビジネスシステムズ. All rights reserved.
//

#import "PreferencesWindowController.h"


@implementation PreferencesWindowController

@synthesize notifyTimeTextField = notifyTimeTextField_;
@synthesize idleTimeTextField = idleTimeTextField_;
@synthesize playAtStartButton = playAtStartButton_;

+ (PreferencesWindowController *)sharedPreferences {
    
    static PreferencesWindowController *preferences;
    
    if (preferences == nil) {
        
        preferences = [[PreferencesWindowController alloc]
                       initWithWindowNibName:@"Preferences"];
    }
    
    return preferences;
}

#pragma mark -
#pragma mark NSWindow Delegate Methods

- (void)windowWillClose:(NSNotification *)notification {
    [[NSApplication sharedApplication] stopModal];
}

#pragma mark -
#pragma mark Accessors

- (NSNumber *)notifyTime {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kNotifyTimeDefaultKey];
}

- (void)setNotifyTime:(NSNumber *)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:kNotifyTimeDefaultKey];
    [defaults synchronize];
}

- (NSNumber *)idleTime {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults objectForKey:kIdleTimeDefaultKey];
}

- (void)setIdleTime:(NSNumber *)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:value forKey:kIdleTimeDefaultKey];
    [defaults synchronize];
}


- (Boolean *)playAtStart {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return [defaults boolForKey:kPlayAtStartDefaultKey];
}

- (void)setPlayAtStart:(Boolean *)value {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSNumber *valNum = [NSNumber numberWithBool:value];
    [defaults setObject:valNum forKey:kPlayAtStartDefaultKey];
    [defaults synchronize];
}

@end
