import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    //this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window)
      
    const customMarker = document.createElement("div")
    customMarker.className = "marker"
    customMarker.idName = "custom_marker"
    customMarker.id = `custom_marker_${marker.id}`  

    // if (marker['url'] === nil) {
    //   console.log("I'm nil")
    //   customMarker.style.backgroundImage = "/app/assets/images/logo-small.png"
    // } else {
     customMarker.style.backgroundImage = `/app/assets/images/logo-small.png`
    // }

    customMarker.style.backgroundSize = "contain"
    //customMarker.style.width = "40px"
    //customMarker.style.height = "40px"
    //customMarker.style.borderRadius = "50%"
    customMarker.style.border = "1px solid red"


      new mapboxgl.Marker(customMarker)
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(this.map)
    })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
