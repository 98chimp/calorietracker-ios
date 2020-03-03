# calorietracker-ios
A simple app to track calories consumed from a list of common foods.

# Architectural Considerations
The app was conceived of using the classic **MVC** design pattern.
There is/are: 
- a few `Manager` classes that handle dealing with persistence, delivering alerts and manipulating data.
- a single `NSManagedObject` data model to persist data using `CoreData` framework.
- a number of reusable UI components to maintain consistency and stability in the app.

# Deisgn Considerations
Ample time was dedicated to visual design of the app a fully clickable prototype that very closely approximates the final UX was created first before development began. This clickable prototype is available by running `Designs.sketch` (located at the root of the repo) using `Sketch App`.

# Installation Details
1. Clone the repo
2. Open the `CalorieTracker.xcworkspace`
3. Run the app after connecting to a physical device or selecting a simulator from Xcode.

# App Features
## My Foods (Home) Screen

1. Add new food items to your list.
   - Tap on the + button
   - Add a photo from the camera or photo library
   - Add a name for the food item
   - Add the number calories
   - Tap **Save**
  
2. List of all foods
   - Tap on an item to see a list of options
     - Add the item to today's list
     - Edit an item
     - Delete the item from the list
   - **BONUS 1:** These functions are also captured in swipe gestures for each row in the list.
   - **BONUS 2:** Mock food items can be added to and deleted from the app with a simple shake gesture while viewing the **My Foods** screen.

## Today Screen

1. Add an existing food item to today's list
   - Tap on the **+** button
   - Select one or more existing items
   - Tap on **Done**
   
2. Remove item from today's list
   - Swipe left (⬅️) on single row to reveal the **Remove** action and tap on it or swipe all the way to the left to remove the item from the today's list.
   
## Trends Screen

1. Switch from a 7-day to a 30-day view of your caloric input trend.
2. Switching reloads the screen with a pleasant animation.
3. Tapping on each item provides a breakdown of food consumed on that specific date.
4. **BONUS**: View a graph of a 7-day or 30-day trend simply by tapping on the chart button (top right).
   - Interact with the chart to see date and calories update at the top of the screen
   - Stop interacting and the screen falls back on showing you today's calories.

# UI Testing Details
A number of UI test cases were added to provide some automated testing of the app using mock data. The test covers ~60% of the code and is by no means exhaustive. However, to see the automated testing in action, follow these steps while **NOT** running the app on Xccode:
1. Delete any mock data from the app
   - Tap on the home screen (My Foods)
   - Shake the device (or simulate shake gesture)
   - Select **Delete**
2. Add a fresh batch of mock data
   - Tap on the home screen (My Foods)
   - Shake the device (or simulate shake gesture)
   - Tap **ADD**

Then **RUN tests** (**⌘-U**) on your device or simulator, sit back and watch the automation in action!

## Known Issues:
- The app is currently designed such that each food item can be added to today's list *only* once. This limitation is surpassed during mock data generation.
- A warning is emitted in the debug console whenever an action sheet is presented. This warning is related to broken layout constraints which appear to be an unresolved iOS 12.2 [bug](https://stackoverflow.com/questions/55372093/uialertcontrollers-actionsheet-gives-constraint-error-on-ios-12-2-12-3).
- A similar warning is emitted in the debug console when flow layout of the Trends collection view changes from 7-day to 30-day. I could not find the root cause of this warning.
- A number of build/run time warnings are emitted relating to the `JBChartView` framework being a little out of date.
- Sometimes the image view in the **Add New Food** screen looks improperly cropped. This can be solved by refreshing the `My Stores` scene in `MyFoods.storyboard` (selecting an iPad device and then an iPhone device or vice-versa) and re-running the app.

## Next Steps
- Modify the model layer to allow multiple entries of the same food item per day.
- Optimize the layout for iPad screens.
- Add unit and UI test cases to improve code coverage.

## Update
A bug that allowed multiple food items with the same _name_ be entered into the data base was discovered and fixed.
