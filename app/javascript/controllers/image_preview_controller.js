import { Controller } from "@hotwired/stimulus"
import EXIF from 'exif-js'

function ConvertDMSToDD(degrees, minutes, seconds, direction) {
  var dd = degrees + minutes/60 + seconds/(60*60);

  if (direction == "S" || direction == "W") {
      dd = dd * -1;
  } // Don't do anything for N or E
  return dd;
}


// Connects to data-controller="image-uploader"
export default class extends Controller {

  static targets = [ "output", "input", "camera", "creation", "location", "aperture", "lens", "focal_length", "warning"]

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
    const warning = this.warningTarget

    if (input.files && input.files[0]) {
      const reader = new FileReader();

      reader.onload = function () {
       output.src = reader.result
       output.style.display = ''
     }


     EXIF.getData(input.files[0], function () {
      const allMetaData = EXIF.getAllTags(this);
      console.log(allMetaData);

      if (EXIF.getTag(this, "GPSLatitude") || EXIF.getTag(this, "DateTime")) {
        console.log('This photo have a location')
      } else {
        warning.style.display = "block";
        console.log('This photo doesnt have a location')
      }


      const latit = ConvertDMSToDD(parseFloat(EXIF.getTag(this, "GPSLatitude")[0]), parseFloat(EXIF.getTag(this, "GPSLatitude")[1]), parseFloat(EXIF.getTag(this, "GPSLatitude")[2]), EXIF.getTag(this, "GPSLatitudeRef"))
      const longit = ConvertDMSToDD(parseFloat(EXIF.getTag(this, "GPSLongitude")[0]), parseFloat(EXIF.getTag(this, "GPSLongitude")[1]), parseFloat(EXIF.getTag(this, "GPSLongitude")[2]), EXIF.getTag(this, "GPSLongitudeRef"))
      const loc = [latit, longit]
      console.log(loc)

      camera.value = EXIF.getTag(this, "Model");
      creation.value = EXIF.getTag(this, "DateTime");
      location.value = loc;
      aperture.value = EXIF.getTag(this, "ApertureValue");
      lens.value = "none"
      focal_length.value = EXIF.getTag(this, "FocalLength");

    });


     reader.readAsDataURL(input.files[0]);
    }

  }
}
