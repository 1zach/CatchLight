import { Controller } from "@hotwired/stimulus"
import { left } from "@popperjs/core";




// Connects to data-controller="resizer"
export default class extends Controller {
  static targets = ["center", "left", "right", "parent"]
  
  initializer() {
  left = this.leftTarget;
  right = this.rightTarget;
  this.x = 0 
  this.y = 0
  
  }
  connect() {
  }

  

}
  resize(e) {
    this.leftWidth = 0;
    this.rightWidth = 0;
    this.x = e.clientX
    this.y = e.clientY
    console.log(this.x)
    console.log(this.y)
    console.log("HI")
    
    this.leftWidth = this.leftTarget.getBoundingClientRect().width;
    this.rightWidth = this.rightTarget.getBoundingClientRect().width;

    console.log(this.leftWidth)

    mouseMoveHandler();
    mouseUpHandler();
    mouseMoveHandler(e) {
      
      console.log("THis works")
      const dx = e.clientX - this.x;
      const dy = e.clientY - this.y;
      const newLeftWidth = ((this.leftWidth + dx) * 100 / this.parentTarget.getBoundingClientRect().width);
      const newRightWidth = ((this.rightWidth - dx) * 100 / this.parentTarget.getBoundingClientRect().width);
      this.leftTarget.style.width = `${newLeftWidth}%`;
      this.rightTarget.style.width = `${newRightWidth}%`;
      this.centerTarget.style.cursor = 'col-resize';
      this.leftTarget.style.userSelect = 'none';
      this.leftTarget.style.pointerEvents = 'none';

      this.rightTarget.style.userSelect = 'none';
      this.rightTarget.style.pointerEvents = 'none';
    }

    const mouseUpHandler = function () {
      
      this.centerTarget.style.removeProperty('cursor');
      //document.body.style.removeProperty('cursor');
  
      this.leftTarget.style.removeProperty('user-select');
      this.leftTarget.style.removeProperty('pointer-events');
  
      this.rightTarget.style.removeProperty('user-select');
      this.rightTarget.style.removeProperty('pointer-events');
      //this.centerTargetDisconnected(center)
}

}
