#yampa-programming

This very simple 3D scene shows a sphere, which changes its color. The camera is rotating around the sphere and the camera's focus can be moved with the mouse.

You can build it by typing the following in the command line:
>ghc --make main.hs -XArrows -odir odir -hidir hidir

It was created using the [FRP](http://en.wikipedia.org/wiki/Functional_reactive_programming "FRP on Wikipedia") language [*Yampa*](http://www.haskell.org/haskellwiki/Yampa "Yampa on HaskellWiki") and and the [OpenGL-binding for Haskell](http://www.haskell.org/haskellwiki/Opengl "HOpenGL on HaskellWiki") on an [Ubuntu 10.04](http://www.ubuntu.com/ "ubuntu homepage") VM.

I assume all the code works on Windows / Mac too, but the reason I chose to develop on Ubuntu is simply the easy-to-use [*cabal*](http://www.haskell.org/cabal/ "cabal homepage") program which makes installing packages for [GHC](http://en.wikipedia.org/wiki/Glasgow_Haskell_Compiler "ghc on wikipedia") a breeze.

**Versions and sources** of the different packages needed:
* [Haskell Platform 2011.2.0.1.2](http://packages.ubuntu.com/oneiric/all/haskell-platform/download "Haskell platform mirrors")
* [Yampa-0.9.3](http://hackage.haskell.org/package/Yampa-0.9.3 "Yampa on hackage")
* [OpenGL-2.5.0.0](http://hackage.haskell.org/package/OpenGL-2.5.0.0 "OpenGL package on hackage")
* [GLUT-2.3.0.0](http://hackage.haskell.org/package/GLUT-2.3.0.0 "GLUT package on hackage")
