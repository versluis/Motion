# Motion Demo
iOS 9 project demonstrating how to gather CMMotionActivity events.

The project has two buttons at the top to start and stop receiving updates from the CMMotionActivityManager. If no motion events are available on the current hardware, an alert is shown.

When started, a series of labels is updated on the screen, depending on the the current state (i.e. standing still, walking, running, etc). The app also shows how confident the app is of the current state.

It is possible for several states to appear at the same time: for example when a driving car comes to an uprupt stop, both "automotive" and "stationary" could both return YES at the same time. For this reason the app also shows a label for each state at the bottom of the screen, even if they return YES at the same time (happens rarely, but it happens).
