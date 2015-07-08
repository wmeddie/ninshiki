/*
 AboutWindowController.m

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

#import "AboutWindowController.h"


@implementation AboutWindowController

+ (AboutWindowController *)sharedAbout {
    
    static AboutWindowController *about;
    
    if (about == nil) {
        about = [[AboutWindowController alloc]
                 initWithWindowNibName:@"About"];
    }
    
    return about;
}

#pragma mark -
#pragma mark NSWindow Delegate Methods

- (void)windowWillClose:(NSNotification *)notification {
    [[NSApplication sharedApplication] stopModal];
}

@end
