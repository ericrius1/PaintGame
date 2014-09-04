THREE = require 'three'
require 'OrbitControls'
require 'ObjectControls'
TWEEN = require 'tween.js'
$ = require 'jquery'


time = null
WIDTH = window.innerWidth
HEIGHT = window.innerHeight
clock = new THREE.Clock()
scene = new THREE.Scene()
camera = new THREE.PerspectiveCamera(50, WIDTH/HEIGHT, 0.001, 20000)
camera.position.z = 50
renderer = new THREE.WebGLRenderer({antialias: true})
renderer.setSize WIDTH, HEIGHT
document.body.appendChild renderer.domElement
controls = new THREE.OrbitControls(camera)
debugger
objectControls = new ObjectControls(camera)
# controls = new THREE.FlyControls(camera)


box = new THREE.Mesh new THREE.BoxGeometry(5, 10, 5), new THREE.MeshNormalMaterial()
scene.add box
box.select = ->
  console.log 'yar'
objectControls.add box


plane = new THREE.Mesh new THREE.PlaneGeometry(1000, 1000)
plane.rotation.x = -Math.PI/2
plane.position.y -=20

scene.add plane

animate = ()->
  time = clock.getElapsedTime()
  requestAnimationFrame(animate)
  renderer.render scene, camera
  controls.update()
  objectControls.update()
  TWEEN.update()






window.onload = ()->
  window.addEventListener('resize', onWindowResize, false)

onWindowResize = ()-> 
  renderer.setSize(window.innerWidth, window.innerHeight);
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();

animate()


$(renderer.domElement).on 'click', (event)->
  hitCheck(event)
