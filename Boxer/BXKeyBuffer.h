/* 
 Boxer is copyright 2011 Alun Bestor and contributors.
 Boxer is released under the GNU General Public License 2.0. A full copy of this license can be
 found in this XCode project at Resources/English.lproj/BoxerHelp/pages/legalese.html, or read
 online at [http://www.gnu.org/licenses/gpl-2.0.txt].
 */

//BXKeyBuffer implements a circular buffer used for entering characters directly to DOS,
//bypassing the keyboard mapper and BIOS keyboard handling.

#import <Foundation/Foundation.h>

#define BXKeyBufferSize 16384
#define BXNoKey 0

@interface BXKeyBuffer : NSObject
{
    UInt16 _keyCodes[BXKeyBufferSize];
    NSUInteger _readIndex;
    NSUInteger _addIndex;
}

//The number of keys currently in the buffer.
@property (readonly) NSUInteger count;

//Returns the BIOS-level keycode that best matches the specified unicode character.
//Returns BXNoKey if there is no suitable match.
+ (UInt16) BIOSKeyCodeForCharacter: (unichar)character;

//Adds the specified keycode/characters to the end of the buffer.
//Returns YES if the key was added, or NO if the buffer is full.
- (BOOL) addKeyForBIOSKeyCode: (UInt16)key;
- (BOOL) addKeysForCharacters: (NSString *)characters;

//Returns the next available key in the buffer, without advancing the buffer.
//Returns BXNoKey if the buffer is empty.
- (UInt16) currentKey;

//Returns the next available key in the buffer and advances the buffer to consume the key.
//Returns BXNoKey if the buffer is empty.
- (UInt16) nextKey;

//Empties the key buffer.
- (void) empty;

@end
