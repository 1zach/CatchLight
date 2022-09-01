import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ["range", "bubble"]
  connect() {
  }

  bubble(e) {
    
    console.log("WHTAT THE FUCK SI INEH OREJI")
  const val = 10;
  //const min = range.min ? range.min : 0;
  //const max = range.max ? range.max : 5;
  //const newVal = Number(((val - min) * 100) / (max - min));
  this.bubbleTarget.innerHTML = val;

  // Sorta magic numbers based on size of the native UI thumb
  //bubble.style.left = newVal = "%";

  bubble.style.left = `calc(${newVal}% + (${8 - newVal * 0.15}px))`;
  }
}
