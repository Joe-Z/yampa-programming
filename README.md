#yampa-programming

This very simple 3D scene shows a sphere, which changes its color. The camera is rotating around the sphere and the camera's focus can be moved with the mouse.

You can build it by typing the following in the command line:
>ghc --make main.hs -XArrows -odir odir -hidir hidir

It was created using the [FRP](http://en.wikipedia.org/wiki/Functional_reactive_programming, "FRP on Wikipedia") language [Yampa](http://www.haskell.org/haskellwiki/Yampa, "Yampa on HaskellWiki") and and an [OpenGL-binding for Haskell](http://www.haskell.org/haskellwiki/Opengl,"HOpenGL on HaskellWiki").

The versions used are:
*ghc-version-link
*yampa-version-link
*hopengl-version-link
*glut-version-link
