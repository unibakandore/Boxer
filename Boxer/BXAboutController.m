/* 
 Boxer is copyright 2011 Alun Bestor and contributors.
 Boxer is released under the GNU General Public License 2.0. A full copy of this license can be
 found in this XCode project at Resources/English.lproj/BoxerHelp/pages/legalese.html, or read
 online at [http://www.gnu.org/licenses/gpl-2.0.txt].
 */

#import "BXAboutController.h"
#import "BXAppController.h"


@implementation BXAboutController
@synthesize version;

+ (id) controller
{
	static id singleton = nil;

	if (!singleton) singleton = [[self alloc] initWithWindowNibName: @"About"];
	return singleton;
}

//Set up all the appearance properties we couldn't in Interface Builder
- (void) awakeFromNib
{
	NSWindow *theWindow	= [self window];
	
	//Let the window be moved by clicking anywhere inside it
	[theWindow setMovableByWindowBackground: YES];
	
	//Set the version's number and appearance
	NSString *versionFormat	= NSLocalizedString(@"Version %1$@ | build %2$@", @"Version string for display in About panel. %1$@ is human-readable version (e.g. 1.0beta), %2$@ is build number (e.g. 20090323-1.)");
	NSString *versionName	= [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
	NSString *buildNumber	= [[NSBundle mainBundle] objectForInfoDictionaryKey: (NSString *)kCFBundleVersionKey];
	NSString *versionString	= [NSString stringWithFormat: versionFormat, versionName, buildNumber];
	[version setStringValue: versionString];
    
    //Add a bottom border to the window
    [theWindow setContentBorderThickness: 41.0f forEdge: NSMinYEdge];
}

- (IBAction) showAcknowledgements: (id)sender
{
	[[NSApp delegate] showHelpAnchor: @"acknowledgements"];
}

@end


@implementation BXAboutBackgroundView

- (void) drawRect: (NSRect)dirtyRect
{
    NSImage *background = [NSImage imageNamed: @"AboutBackground"];
    
    [background drawInRect: [self bounds]
                  fromRect: NSZeroRect
                 operation: NSCompositeSourceOver
                  fraction: 1.0f];
    
    //Render vignetting
    NSGradient *lighting = [[NSGradient alloc] initWithColorsAndLocations:
                            [NSColor colorWithCalibratedWhite: 0 alpha: 0],     0.0f,
                            [NSColor colorWithCalibratedWhite: 0 alpha: 0.4f],  1.0f,
                            nil];
    
    [lighting drawInRect: [self bounds] relativeCenterPosition: NSMakePoint(0.25f, 0.5f)];
    
    [lighting release];
}

@end
