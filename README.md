# RBTransformers
RBTransformers

Project startup:
1. Checkout the develop branch
2. Open RBTransformers.xcworkspace
3. Run in a simulator
4. War starts automatically in the ViewController’s startWar method
5. Observe the results in the UI or a bit more detailed results in the console log


Input: 
transformers.json file in the project directory is being used as the source file for the war lineup. Feel free to modify it and re run the application again to see the new results.
Some fail safe checks are in place, but not all corner cases are covered for invalid input.


Output:
The RBWarMachine singleton delivers a RBWarResult class object to the ViewController upon conclusion of a war. It can be examined for further result details.

// war end result enum
@property (nonatomic, assign, readonly) RBBattleResult result;

// the count for how many battles took place
@property (nonatomic, assign, readonly) int battlesFought;

// an array of RBTransformer class objects of the winning team members.
@property (nonatomic, strong, readonly) NSArray <RBTransformer*> *winningTeamMembersArray;

// an array of RBTransformer class objects of the surviving losing team members.
@property (nonatomic, strong, readonly) NSArray <RBTransformer*> *survivingLosingTeamMembersArray;

// concatenated names of the winning team members
@property (nonatomic, strong, readonly) NSString *winningTeamMembersNames;

// concatenated names of the losing team members
@property (nonatomic, strong, readonly) NSString *losingTeamMembersNames;

// a concatenated full results description string
@property (nonatomic, strong, readonly) NSString *resultDescription;

