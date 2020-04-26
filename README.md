# ecohub

_This was all made during EarthxHack 2020._

***ecohub** is an application where you and your friends can get **volunteer hours**
for doing various tasks around your area. This is the time where you can shine your
resume and pride while helping the environment.

All it takes is a simple picture and a hunt for volunteering requests with your friends.

## How It Works
1. Register as a user    
2. Profile keeps track of hours.    
3. View your opportunities.
4. Read about an opportunity.    
5. Submit your work.

 <img src="/images/step1.PNG" width="200"><img src="/images/step2.PNG" width="200"><img src="/images/step3.png" width="200">
 
 <img src="/images/step4.PNG" width="200"><img src="/images/step5.png" width="200">


A simple user can use those 5 steps to gain volunteering hours alone or with their
friends.

A separate account is given to organizers which allows for the creation of events
and accepting the volunteer works of different users.

<img src="/images/Map.png" width="200"> <img src="/images/Feed.png" width="200"> <img src="/images/acceptdeny.png" width="200">

## Technologies Utilized

 * Flutter
 * Google Firebase
 * Android Studio
 * Google Maps API

### Flutter
We utilized a [Flutter] (https://flutter.dev/) frontend that uses the Dart programming language developed by
Google to create multiplatform apps. We chose Flutter over React Native because we believed
Dart was closer to Java which fit best with our personal experiences. Also, Flutter seems to be
more flexible in terms of UI.

### Firebase
We also used [Google Firebase] (https://firebase.google.com/) as a database as it provided a free
trial with sufficent storage. Also, due to prior bad experiences with Amazon AWS, we decided to turn
to Firebase. Also it provided quick authentication and usable API with Flutter.

### Android Studio
Finally, Android Studio was used for developing the application and testing by the developers. We
were able to use the Android virtual devices to test the application.

### Google Maps API
We use this API in order to tell our users where they can fulfill their event requirements. It
also helps recommend options for users to choose based on proximity.

## Usable Platforms

The mobile app runs on both Android and iOS.

## Challenges We Faced

### 1. Challenge 1

We faced many problems with Google Maps API such as cost. We had to search for a free version that
allowed us to get a static image of a map due to the fact that the google maps API requires you
to link a billing account.

### 2. Challenge 2

We had to learn Dart and Firebase from scratch. We all started this as a new language. This hackathon
was also our entire team's first hackathon ever, so we got to learn new things and have fun.

### 3. Challenge 3

We had problems up until the last minute with code changes and code breaking down all over the place.
With a live database, it was hard to work with multiple using it at the same time with different ideas.
Teamwork also became a double edged sword. Asynchronous code and asynchronous coding can be annoying lol.

## Inspiration

X2Vol and other volunteering sites along with Meetup. We combined the two app ideas to come up with this
benefical and fun app helps the environment and the users.

## Accomplishments

Our app is completed by the end luckily. We got the core components into the app despite not being able
to add some features. We had very nice looking dark mode UI and it works well as intended with minimal
problems.

