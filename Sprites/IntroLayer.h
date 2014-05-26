//
//  IntroLayer.h
//  Sprites
//
//  Created by jeremy wall on 4/17/13.
//  Copyright jeremy wall 2013. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface IntroLayer : CCLayer
{
	 CCMenuItem* menu;
	
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
