import { Controller } from "@hotwired/stimulus"
import EXIF from 'exif-js'

// Connects to data-controller="image-uploader"
export default class extends Controller {

  static targets = [ "output", "input", "camera", "creation", "location", "aperture", "lens", "focal_length" ]

  connect() {

  }

  readURL() {
    const input = this.inputTarget
    const output = this.outputTarget
    const camera = this.cameraTarget
    const creation = this.creationTarget
    const location = this.locationTarget
    const aperture = this.apertureTarget
    const lens = this.lensTarget
    const focal_length = this.focal_lengthTarget

    if (input.files && input.files[0]) {
      const reader = new FileReader();

      reader.onload = function () {
       output.src = reader.result
       output.style.display = ''
     }


     EXIF.getData(input.files[0], function () {
      const allMetaData = EXIF.getAllTags(this);
      console.log(allMetaData);

      camera.value = EXIF.getTag(this, "Model");

      creation.value = EXIF.getTag(this, "DateTime");

      location.value = EXIF.getTag(this, "GPSLatitude");

      aperture.value = EXIF.getTag(this, "ApertureValue");

      lens.value = EXIF.getTag(this, "DateTime");

      focal_length.value = EXIF.getTag(this, "FocalLength");
    });


     reader.readAsDataURL(input.files[0]);
    }

  }
}
