#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
	@autoreleasepool {
		int x = 2;
		int y = x + x;
		float z = y - x;
		y = (z + x) - y;
	}
	return 0;
}
