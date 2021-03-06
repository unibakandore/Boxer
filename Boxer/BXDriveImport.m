/* 
 Boxer is copyright 2011 Alun Bestor and contributors.
 Boxer is released under the GNU General Public License 2.0. A full copy of this license can be
 found in this XCode project at Resources/English.lproj/BoxerHelp/pages/legalese.html, or read
 online at [http://www.gnu.org/licenses/gpl-2.0.txt].
 */

#import "BXDriveImport.h"
#import "BXCDImageImport.h"
#import "BXBinCueImageImport.h"
#import "BXDriveBundleImport.h"
#import "BXSimpleDriveImport.h"

@implementation BXDriveImport: BXOperation

+ (Class) importClassForDrive: (BXDrive *)drive
{
	NSArray *importClasses = [NSArray arrayWithObjects:
							  [BXBinCueImageImport class],
							  [BXCDImageImport class],
							  [BXDriveBundleImport class],
							  [BXSimpleDriveImport class],
							  nil];
	
	for (Class importClass in importClasses)
		if ([importClass isSuitableForDrive: drive]) return importClass;
	
	//If we got this far, no appropriate class could be found
	return nil;
}

+ (id <BXDriveImport>) importOperationForDrive: (BXDrive *)drive
                                 toDestination: (NSString *)destinationFolder
                                     copyFiles: (BOOL)copyFiles
{
	Class importClass = [self importClassForDrive: drive];
	if (importClass)
	{
		return [[[importClass alloc] initForDrive: drive
									toDestination: destinationFolder
										copyFiles: copyFiles] autorelease];
	}
	else return nil;
}

+ (id <BXDriveImport>) fallbackForFailedImport: (id <BXDriveImport>)failedImport
{
	Class fallbackClass = nil;
	
	//Use a simple file copy to replace a failed disc-image rip
	if ([failedImport isKindOfClass: [BXCDImageImport class]])
	{
		fallbackClass = [BXSimpleDriveImport class];
	}
	
	if (fallbackClass)
	{
		//Create a new import operation with the same parameters as the old one
		return [[[fallbackClass alloc] initForDrive: [failedImport drive]
									  toDestination: [failedImport destinationFolder]
										  copyFiles: [failedImport copyFiles]] autorelease];
	}
	//No fallback could be found
	return nil;
}
@end
