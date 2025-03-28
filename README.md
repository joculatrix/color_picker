![image](https://github.com/user-attachments/assets/719f166e-0eb5-44f4-aaa1-9c5c28fd6717)

A work-in-progress color picker app using Qt and QML. Aiming to support X11 and Windows, but Windows has
not been tested.

Currently only picks up mouse events over the color picker window itself, which isn't very helpful. I had
a non-Quick/QML project testing functionality which _did_ pick up events over the entirety of both of my
monitors. I'm unsure what's causing the difference here. Part of me wonders if Qt Creator runs the app in
some sort of different sandboxed way, but learning Qt deployment to be able to run the app outside the IDE
and test this is a headache. It could also be a difference in how Quick works, or having the Controller as
a separate widget instead of as a QApplicationWindow, or something else entirely.
