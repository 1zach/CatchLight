import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ["range", "bubble"]
  connect() {
  }

  bubble() {
  console.log("hey")
  const val = this.rangeTarget.value;
  const min = this.rangeTarget.min ? this.rangeTarget.min : 0.5;
  const max = this.rangeTarget.max ? this.rangeTarget.max : 5.0;
  const newVal = Number(((val - min) * 100) / (max - min));
  this.bubbleTarget.innerHTML = `Radius: ${parseFloat(val).toFixed(1)} km`;

  // Sorta magic numbers based on size of the native UI thumb
  //this.bubbleTarget.style.left = newVal = "%";

  //this.rangeTarget.style.left = `calc(${newVal}% + (${8 - newVal * 0.15}px))`;
  }
}
