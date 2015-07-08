/*
 
 AssTrackerAppDelegate.h
 
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

#import <Cocoa/Cocoa.h>
#import <IOKit/IOKitLib.h>
#import <CoreFoundation/CFNumber.h>
#import "PreferencesWindowController.h"
#import "AboutWindowController.h"

@interface AssTrackerAppDelegate : NSObject <NSApplicationDelegate> {
  @private
    NSStatusItem *__strong statusItem_;
    NSMenu *__strong statusMenu_;
    NSTimer *__strong timer_;
    NSInteger minutes_;
    NSSound *notifySound_;
}

@property (strong) NSStatusItem *statusItem;
@property (strong) IBOutlet NSMenu *statusMenu;
@property (strong) NSTimer *timer;
@property (assign) NSInteger minutes;
@property (strong) NSSound *notifySound;

- (IBAction)showPreferences:(id)sender;
- (IBAction)showAbout:(id)sender;

- (IBAction)quit:(id)sender;

- (void)updateStatusItem;
- (void)updateTimer:(NSTimer *)timer;
    
@end
