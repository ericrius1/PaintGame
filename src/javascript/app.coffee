THREE = require 'three'
require 'OrbitControls'
TWEEN = require 'tween.js'
# Fire = require './fire'


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

scene.add(new THREE.Mesh(new THREE.BoxGeometry(10, 10, 10), new THREE.MeshNormalMaterial()))

animate = ()->
  requestAnimationFrame(animate)
  renderer.render scene, camera
  controls.update()
  time = clock.getElapsedTime()
  card.update(time)
  TWEEN.update()



window.onload = ()->
  window.addEventListener('resize', onWindowResize, false)

onWindowResize = ()-> 
  renderer.setSize(window.innerWidth, window.innerHeight);
  camera.aspect = window.innerWidth / window.innerHeight;
  camera.updateProjectionMatrix();

animate()