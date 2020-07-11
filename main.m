#import <objc/Object.h>
#import <objc/runtime.h>
#import <stdlib.h>
#import <stdio.h>

@interface Object (myadditions)
-(void) dealloc;
@end

@implementation Object (myadditions)
-(void) dealloc
{ }
@end

@interface Test: Object
{
    char *foo;

    int mSelfCounter;    
}

+(id) alloc;

-(id) init;
-(void) retain;
-(void) release;

-(void) dealloc;

-(void) hello;
@end

@implementation Test

+(id) alloc
{
    printf("alloc");
    id instanceId = class_createInstance(self, 0);
    return instanceId;
}

-(id) init
{
    mSelfCounter++;
    printf("\ninit\n");
    foo = "TEST";
}

-(void) retain
{
    mSelfCounter++;
}

-(void) release
{
    printf("\nrelease\n");
    mSelfCounter--;
    if(mSelfCounter <= 0)
    {
        [self dealloc];
    }
}

-(void) dealloc
{
    printf("\ndealloc called\n");
    object_dispose(self);
    [super dealloc];
}

-(void) hello
{
    printf("\nhello\n");

    printf("\n%s\n", foo);
}
@end

int main(int argc, char **argv)
{
    printf("\nstarting\n");

    Test *t = [[Test alloc] init];
    [t hello];


    [t release];

    return 0;
}
