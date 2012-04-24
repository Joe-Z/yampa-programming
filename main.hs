module Main where

import FRP.Yampa
import Control.Concurrent

import Graphics.Rendering.OpenGL
import Graphics.UI.GLUT
import Data.IORef
import System.Exit

-- helper functions

clamp :: (Ord a) => a -> a -> a -> a
clamp v min max
  | v < min = min
  | v > max = max
  | otherwise = v

coordinateSystem expansion = do 
  renderPrimitive Lines $ do
  -- x-axis
  currentColor $= Color4 1 0 0 1
  vertex $ Vertex3 0 0 (0::GLfloat)
  vertex $ Vertex3 expansion 0 0

  --y-axis
  currentColor $= Color4 0 1 0 1
  vertex $ Vertex3 0 0 (0::GLfloat)
  vertex $ Vertex3 0 expansion 0

  --z-axis
  currentColor $= Color4 0 0 1 1
  vertex $ Vertex3 0 0 (0::GLfloat)
  vertex $ Vertex3 0 0 expansion

data SceneInput = SceneInput
    { mousePos::(Int, Int),
      curSize::(Int, Int)
    }

data SceneState = SceneState
    { eye::Vertex3 GLdouble,
      center::Vertex3 GLdouble,
      up::Vector3 GLdouble,
      colour::Color4 GLfloat,
      heading::GLdouble,
      elevation::GLdouble
    }

-- OpenGL callback functions
reshape curSize s@(Size w h) = do 
  viewport $= (Position 0 0, s)
  curSize $= (fromIntegral w, fromIntegral h)

mouseMovement::IORef (Int, Int) -> Position -> IO()
mouseMovement mPos (Position x y) = do
  mPos $= (fromIntegral x, fromIntegral y)

keyboardMouse (Char '\27') _ _ _ = exitWith ExitSuccess
keyboardMouse _ _ _ _ = return ()

idle input handle = do
  
  sample <- input True

  terminate <- react handle sample

  postRedisplay Nothing

-- main

main :: IO ()
main = do
  (progname,_) <- getArgsAndInitialize

  mPosCur <- newIORef(0, 0::Int)
  size <- newIORef(300, 300::Int)

  handle <- reactInit (myInit size) output process

  passiveMotionCallback $= Just (mouseMovement mPosCur)
  reshapeCallback $= Just (reshape size)
  keyboardMouseCallback $= Just keyboardMouse
  idleCallback $= Just (idle (input mPosCur size) handle)

  mainLoop

-- signal function
headingSF::SF (Int, Int) Int
headingSF = proc (xPos, width) -> do
  let posFactor = (realToFrac xPos) / (realToFrac width)
  returnA -< truncate $ posFactor * 360 - 180

elevationSF::SF (Int, Int) Int
elevationSF = proc (yPos, height) -> do
  let posFactor = (realToFrac yPos) / (realToFrac height)
  returnA -< truncate $ posFactor * 160 - 80

process::SF SceneInput SceneState
process = proc input -> do
  curTime <- time -< input
  heading' <- headingSF -< (fst $ mousePos input, fst $ curSize input)
  elevation' <- elevationSF -< (snd $ mousePos input, snd $ curSize input)

  let curAngle = realToFrac $ fromIntegral ((truncate curTime) `mod` 5001) * (2 * pi) / 5000
      curColor = realToFrac $ curTime / 100
      headingRad = (fromIntegral heading') * (pi / 180)
      elevationRad = (fromIntegral elevation') * (pi / 180)

  returnA -< SceneState{ eye = Vertex3 (cos curAngle * 3) (sin curAngle * 3) (3::GLdouble),
                         center = Vertex3
                           (cos(headingRad) * cos(elevationRad))
                           (sin(headingRad) * cos(elevationRad))
                           (sin(elevationRad)),
                         up = Vector3 0 0 (1::GLdouble),
                         colour = Color4 (cos curColor) (sin curColor) 1 1,
                         heading = fromIntegral heading',
                         elevation = fromIntegral elevation'
                       }

-- reactimation IO

myInit :: IORef(Int, Int) -> IO SceneInput
myInit s = do

  initialDisplayMode $= [DoubleBuffered, WithDepthBuffer]

  size <- get s

  initialWindowSize $= Size (fromIntegral $ fst size) (fromIntegral $ snd size)

  createWindow "final scene"

  depthFunc $= Just Less

  matrixMode $= Projection

  loadIdentity

  let near = 0.75
      far = 20
      right = 1
      top = 1

  frustum (-right) right (-top) top near far

  clearColor $= Color4 1.0 1.0 1.0 0.0

  return SceneInput
    { mousePos = (0, 0),
      curSize = size
    }

input :: IORef (Int, Int) -> IORef (Int, Int) -> Bool -> IO (DTime, Maybe SceneInput)
input mPos size _ = do
  let deltaTime = 1000 / 30
  threadDelay $ truncate (deltaTime * 1000)
  curPos <- get mPos
  size' <- get size

  --putStrLn $ "curPos: " ++ show curPos
  --putStrLn $ "size': " ++ show size'
  return (deltaTime, Just (SceneInput{ mousePos = curPos, curSize = size' }))

output :: ReactHandle SceneInput SceneState -> Bool -> SceneState -> IO Bool
output _ _ state = do
  clear [ColorBuffer, DepthBuffer]
  
  matrixMode $= Modelview 0
  loadIdentity

  --putStrLn $ "heading: " ++ show (heading state)
  --putStrLn $ "elevation: " ++ show (elevation state)

  lookAt (eye state) (center state) (up state)

  currentColor $= (colour state)
  renderObject Solid (Sphere' 1.5 16 8)

  coordinateSystem (2::GLfloat)

  swapBuffers

  return False
