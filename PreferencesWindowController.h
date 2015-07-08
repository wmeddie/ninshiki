/*
 PreferencesWindowController.h
 
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


@interface PreferencesWindowController : NSWindowController<NSWindowDelegate> {
  @private
    NSTextField *__strong notifyTimeTextField_;
    NSTextField *__strong idleTimeTextField_;
}

@property (strong) IBOutlet NSTextField *notifyTimeTextField;
@property (strong) IBOutlet NSTextField *idleTimeTextField;
@property (strong) IBOutlet NSButton *playAtStartButton;
@property (copy) NSNumber *notifyTime;
@property (copy) NSNumber *idleTime;
@property Boolean *playAtStart;


+ (PreferencesWindowController *)sharedPreferences;

@end
