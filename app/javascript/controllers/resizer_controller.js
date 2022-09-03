import { Controller } from "@hotwired/stimulus"
import { left } from "@popperjs/core";




// Connects to data-controller="resizer"
export default class extends Controller {
  static targets = ["center", "left", "right", "parent"]
  left = this.leftTarget;
  right = this.rightTarget;
  x = 0 
  y = 0
  leftWidth = 0;
  connect() {
  }
  resize(e) {
    
    x = e.clientX
    y = e.clientY
    console.log(x)
    console.log(y)
    console.log("HI")
    
    leftWidth = left.getBoundingClientRect().width;
    console.log(leftWidth)

    mouseMoveHandler();
    mouseMoveHandler(e) {
      
      console.log("THis works")
      const dx = e.clientX - x;
      const dy = e.clientY - y;
      const newLeftWidth = ((leftWidth + dx) * 100 / resizer.parent.getBoundingClientRect().width);
      left.style.width = `${newLeftWidth}%`;
    }

  }

 

  
}
