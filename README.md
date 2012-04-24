#yampa-programming

This very simple 3D scene shows a sphere, which changes its color. The camera is rotating around the sphere and the camera's focus can be moved with the mouse.

You can build it by typing the following in the command line:
>ghc --make main.hs -XArrows -odir odir -hidir hidir

It was created using the [FRP](http://en.wikipedia.org/wiki/Functional_reactive_programming "FRP on Wikipedia") language [Yampa](http://www.haskell.org/haskellwiki/Yampa "Yampa on HaskellWiki") and and an [OpenGL-binding for Haskell](http://www.haskell.org/haskellwiki/Opengl "HOpenGL on HaskellWiki").

The versions used are:
* [Haskell Platform 2011.2.0.1.2](http://packages.ubuntu.com/oneiric/all/haskell-platform/download "Haskell platform mirrors")
* [Yampa-0.9.3](http://hackage.haskell.org/package/Yampa-0.9.3 "Yampa on hackage")
* [OpenGL-2.5.0.0](http://hackage.haskell.org/package/OpenGL-2.5.0.0 "OpenGL package on hackage")
* [GLUT-2.3.0.0](http://hackage.haskell.org/package/GLUT-2.3.0.0 "GLUT package on hackage")
