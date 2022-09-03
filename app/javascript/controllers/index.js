// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import ImagePreviewController from "./image_preview_controller"
application.register("image-preview", ImagePreviewController)

import MapController from "./map_controller"
application.register("map", MapController)

import ResizerController from "./resizer_controller"
application.register("resizer", ResizerController)

import SliderController from "./slider_controller"
application.register("slider", SliderController)
