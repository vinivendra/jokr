#import <Foundation/Foundation.h>
#import "SomeClass.h"

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		SomeClass *foo = [SomeClass new];
		int x = [foo five];
		NSLog(@"%d\n", x);
	}
	return 0;
}
