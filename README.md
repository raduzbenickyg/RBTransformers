# RBTransformers
RBTransformers

This is an Objective-C project I've done to showcase a few different programming techniques. 

Objectives:
The Transformers are at war and  you  are in charge of settling the score! You’re to evaluate who wins a fight between the Autobots and the Decepticons. Here are the rules.

● Each Transformer has the following criteria on their tech spec: Strength, Intelligence, Speed, Endurance, Rank, Courage , Firepower, Skill
● The “overall rating” of a Transformer is the following formula: (Strength + Intelligence + Speed + Endurance + Firepower)
● Each Transformer must either be an Autobot or a Deception.
● The program takes input that describes a group of Transformers and based on that group displays: The number of battles, The winning team, The surviving members of the losing team
● The teams is pre-sorted by rank and faced off one on one against each other in order to determine a victor, the loser is eliminated
● A battle between opponents uses the following rules:
● If any fighter is down 4 or more points of courage and 3 or more points of strength compared to their opponent, the opponent automatically wins the face-off regardless of overall rating (opponent has ran away)
● Otherwise, if one of the fighters is 3 or more points of skill above their opponent, they win the fight regardless of overall rating
● The winner is the Transformer with the highest overall rating
● In the event of a tie, both Transformers are considered destroyed
● Any Transformers who don’t have a fight are skipped (i.e. if it’s a team of 2 vs. a team of 1, there’s only going to be one battle)
● The team who eliminated the largest number of the opposing team is the winner
● Any Transformer named Optimus Prime or Predaking wins his fight automatically regardless of any other criteria
● In the event either of the above face each other (or a duplicate of each other), the game immediately ends with all competitors destroye


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

