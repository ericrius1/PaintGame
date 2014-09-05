THREE = require 'three'
require 'OrbitControls'
require 'ObjectControls'
TWEEN = require 'tween.js'
$ = require 'jquery'
require 'mithril'


time = null
WIDTH = window.innerWidth
HEIGHT = window.innerHeight
clock = new THREE.Clock()
scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera(45, WIDTH/HEIGHT, 1, 20000)
camera.position.z = 50
renderer = new THREE.WebGLRenderer({antialias: true})
renderer.setSize WIDTH, HEIGHT
document.body.appendChild renderer.domElement
controls = new THREE.OrbitControls(camera)
objectControls = new ObjectControls(camera)
# controls = new THREE.FlyControls(camera)

canvas = document.createElement('canvas')
canvas.width = 2000
canvas.height = 2000
ctx = canvas.getContext('2d')
ctx.fillStyle = 'white'
ctx.fillRect(0, 0, canvas.width, canvas.height )
canvasTexture = new THREE.Texture(canvas) 
canvasTexture.needsUpdate = true;

floorMat = new THREE.MeshBasicMaterial 
  map: canvasTexture
floor = new THREE.Mesh new THREE.PlaneGeometry(canvas.width, canvas.height)
floor.rotation.x = -Math.PI/2
floor.position.y -=20

scene.add floor

box = new THREE.Mesh new THREE.BoxGeometry(50, 100, 50), new THREE.MeshNormalMaterial()
box.position.y += 120
scene.add box

xhrConfig = (xhr)->
  xhr.setRequestHeader("Access-Control-Alow-Origin", "*")
box.select = ->
  console.log 'yar'
  box.visible = false
  ctx.fillStyle = 'red'
  ctx.beginPath()
  x = map(box.position.x, -canvas.width/2, canvas.width/2, 0, canvas.width)
  y = map(box.position.y, -canvas.height/2, canvas.height/2, 0, canvas.height)
  ctx.arc(x, y, 10, 0, Math.PI * 2)
  ctx.fill()
  canvasTexture.needsUpdate = true
  m.request
    method: 'GET'
    url: 'http://glacial-temple-3112.herokuapp.com/'
    config: xhrConfig
objectControls.add box



animate = ()->
  time = clock.getElapsedTime()
  requestAnimationFrame(animate)
  renderer.render scene, camera
  controls.update()
  objectControls.update()
  TWEEN.update()


 map = (value, min1, max1, min2, max2)->
  min2 + (max2 - min2) * ((value - min1) / (max1 - min1))



window.onload = ()->
  window.addEventListener('resize', onWindowResize, false)

onWindowResize = ()-> 
  renderer.setSize(window.innerWidth, window.innerHeight);
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();

animate()

