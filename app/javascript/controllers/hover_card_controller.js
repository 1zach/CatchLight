import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="hover-card"
export default class extends Controller {
    connect() {
        console.log("Hover")
      }
    
      hover(e) {
          let id = e.currentTarget.dataset.id 
          let idDiv = `#custom_marker_${id}`
          let div = document.querySelector(idDiv)
          div.style.border = "1px solid gold"
          div.style.width = "90px"
          div.style.height ="90px"
          div.style.zIndex = 2000000
      }
    
      out(e) {
        let id = e.currentTarget.dataset.id 
        let idDiv = `#custom_marker_${id}`
        let div = document.querySelector(idDiv)
        div.style.border = "1px solid white"
        div.style.width = "60px"
        div.style.height ="60px"
        div.style.zIndex = 5     
    }
}
