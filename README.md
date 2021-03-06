# StepsTrackerPrototype

## About
Developed a steps tracker applicaion using Flutter and Firebase, where users can register as anonymous user and track their steps and get extra points where user can exchange it with reward.
## Notice:
 - This version only support Android 
 - This version working on Flutter 2.0.6 and Dart 2.12.3
# Usage
 ```
   - $ git clone https://github.com/WejdanCS/steps_tracker_prototype.git
   - $ cd StepsTrackerPrototype
   - $ flutter pub get
   - $ flutter run
 ```
 
 # Features
 
- [x] User can login as anonymous user
  
- [x] Track user steps

- [x] get extra points ,extra points =10% of total steps.

- [x] Display user History (display exchanged points and added points) with date and time.

- [x] Show a visual feedback (Snack bar) when users gain extra points.
- [x] Display dialog of rewards so users can pick a reward they like and redeem it.Each reward is linked to one partner.
- [x] Rewards are paid with health points, display feedback given upon all cases: if the 
redemption can happen, show a confirmation dialog, if it cannot due to a low number of 
points, show an error message stating clearly what’s wrong.
- [x] Display leaderboard where the user can see their ranking (how many 
steps they have made since installing the app) compared to all other users, to encourage 
them to walk more.

# SnapShots
 ## Login Page and Permission
![snapshots](/snapshots/logn_permission.svg)

 ## Home Page
![snapshots](/snapshots/homePage.svg)
 ## History
![snapshots](/snapshots/history.svg)
 ## Catalog Page
![snapshots](/snapshots/rewardCatalog.svg)



