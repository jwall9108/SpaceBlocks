//
//  MyCocos2DClass.h
//  Sprites
//
//  Created by jeremy wall on 5/10/13.
//  Copyright 2013 jeremy wall. All rights reserved.
//

#import "SimpleAudioEngine.h"
#import "cocos2d.h"
#import "IntroLayer.h"
#import "AppDelegate.h"



@interface Layer2 : CCLayerColor{
	
		int cont;
		int nShotsLeft;
		double bulletVelocity;
		CCArray *aBullets;
		CCLabelTTF *lblAmmo;
		CCLabelTTF *lblScore;
		CCLabelTTF *lblLose;
		CCParticleSystem *snow;
		CCSpriteBatchNode *spriteBatch;
		CCParticleSystemQuad *explosion;
		CCMenuItem* menu;
		CGSize winSize;
		NSDictionary *dExplosion; 
}

@property (nonatomic, retain) CCSpriteBatchNode *Batch;
@property (nonatomic, retain) NSMutableArray *aBlock;
@property (nonatomic, retain) NSMutableArray *aAmmoPacks;
@property (nonatomic, retain) NSMutableArray *aBulletUpgrade;
@property (nonatomic) int iScore;
@property (nonatomic) int iBulletCount;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;
- (BOOL) ccTouchBegan:(UITouch *)touches withEvent:(UIEvent *)event;
- (void) onPlay:(id)sender;
- (int)  getRandomNumberBetween:(int)from to:(int)to;
- (void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event;
- (void) PreLoadSounds;
- (void) BlockHit:(int)Tag;
- (void) AmmoPackHit;
- (void) Exlplode:(CGPoint)Location;
- (void) GameOver:(NSString*)message;
- (void) SheildHit;
- (void) BulletUpgradeTimer:(ccTime)delta;
-(void) removeMe:(CCSprite*)remove;
@end
