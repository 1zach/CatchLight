import { Controller } from "@hotwired/stimulus"
import EXIF from 'exif-js'

const keys = [ 'Make', 'Model', 'Orientation', 'XResolution', 'YResolution', 'ResolutionUnit', 'Software', 'DateTime', 'undefined', 'ExifIFDPointer', 'GPSInfoIFDPointer', 'ExposureTime', 'FNumber', 'ExposureProgram', 'ISOSpeedRatings', 'ExifVersion', 'DateTimeOriginal', 'DateTimeDigitized', 'ShutterSpeedValue', 'ApertureValue', 'BrightnessValue', 'ExposureBias', 'MeteringMode', 'Flash', 'FocalLength', 'SubjectArea', 'MakerNote', 'SubsecTimeOriginal', 'SubsecTimeDigitized', 'ColorSpace', 'PixelXDimension', 'PixelYDimension', 'SensingMethod', 'SceneType', 'ExposureMode', 'WhiteBalance', 'FocalLengthIn35mmFilm', 'GPSLatitudeRef', 'GPSLatitude', 'GPSLongitudeRef', 'GPSLongitude', 'GPSAltitudeRef', 'GPSAltitude', 'GPSSpeedRef', 'GPSSpeed', 'GPSImgDirectionRef', 'GPSImgDirection', 'GPSDestBearingRef', 'GPSDestBearing', 'GPSDateStamp', 'thumbnail']
const keyDowncase =  ['input', 'output', 'warning',"make", "model", "orientation", "xresolution", "yresolution", "resolutionunit", "software", "datetime", "undefined", "exififdpointer", "gpsinfoifdpointer", "exposuretime", "fnumber", "exposureprogram", "isospeedratings", "exifversion", "datetimeoriginal", "datetimedigitized", "shutterspeedvalue", "aperturevalue", "brightnessvalue", "exposurebias", "meteringmode", "flash", "focallength", "subjectarea", "makernote", "subsectimeoriginal", "subsectimedigitized", "colorspace", "pixelxdimension", "pixelydimension", "sensingmethod", "scenetype", "exposuremode", "whitebalance", "focallengthin35mmfilm", "gpslatituderef", "gpslatitude", "gpslongituderef", "gpslongitude", "gpsaltituderef", "gpsaltitude", "gpsspeedref", "gpsspeed", "gpsimgdirectionref", "gpsimgdirection", "gpsdestbearingref", "gpsdestbearing", "gpsdatestamp", "thumbnail"]

// Connects to data-controller="image-uploader"
export default class extends Controller {
  static targets = keyDowncase

  connect() {

  }

  readURL() {
    const input = this.inputTarget
    const output = this.outputTarget
    const warning = this.warningTarget
    const Make = this.makeTarget
    const Model = this.modelTarget
    const Orientation = this.orientationTarget
    const XResolution = this.xresolutionTarget
    const YResolution = this.yresolutionTarget
    const ResolutionUnit = this.resolutionunitTarget
    const Software = this.softwareTarget
    const DateTime = this.datetimeTarget
    const undefined = this.undefinedTarget
    const ExifIFDPointer = this.exififdpointerTarget
    const GPSInfoIFDPointer = this.gpsinfoifdpointerTarget
    const ExposureTime = this.exposuretimeTarget
    const FNumber = this.fnumberTarget
    const ExposureProgram = this.exposureprogramTarget
    const ISOSpeedRatings = this.isospeedratingsTarget
    const ExifVersion = this.exifversionTarget
    const DateTimeOriginal = this.datetimeoriginalTarget
    const DateTimeDigitized = this.datetimedigitizedTarget
    const ShutterSpeedValue = this.shutterspeedvalueTarget
    const ApertureValue = this.aperturevalueTarget
    const BrightnessValue = this.brightnessvalueTarget
    const ExposureBias = this.exposurebiasTarget
    const MeteringMode = this.meteringmodeTarget
    const Flash = this.flashTarget
    const FocalLength = this.focallengthTarget
    const SubjectArea = this.subjectareaTarget
    const MakerNote = this.makernoteTarget
    const SubsecTimeOriginal = this.subsectimeoriginalTarget
    const SubsecTimeDigitized = this.subsectimedigitizedTarget
    const ColorSpace = this.colorspaceTarget
    const PixelXDimension = this.pixelxdimensionTarget
    const PixelYDimension = this.pixelydimensionTarget
    const SensingMethod = this.sensingmethodTarget
    const SceneType = this.scenetypeTarget
    const ExposureMode = this.exposuremodeTarget
    const WhiteBalance = this.whitebalanceTarget
    const FocalLengthIn35mmFilm = this.focallengthin35mmfilmTarget
    const GPSLatitudeRef = this.gpslatituderefTarget
    const GPSLatitude = this.gpslatitudeTarget
    const GPSLongitudeRef = this.gpslongituderefTarget
    const GPSLongitude = this.gpslongitudeTarget
    const GPSAltitudeRef = this.gpsaltituderefTarget
    const GPSAltitude = this.gpsaltitudeTarget
    const GPSSpeedRef = this.gpsspeedrefTarget
    const GPSSpeed = this.gpsspeedTarget
    const GPSImgDirectionRef = this.gpsimgdirectionrefTarget
    const GPSImgDirection = this.gpsimgdirectionTarget
    const GPSDestBearingRef = this.gpsdestbearingrefTarget
    const GPSDestBearing = this.gpsdestbearingTarget
    const GPSDateStamp = this.gpsdatestampTarget
    const thumbnail = this.thumbnailTarget


    if (input.files && input.files[0]) {
      const reader = new FileReader();

      reader.onload = function () {
       output.src = reader.result
       output.style.display = ''
     }


     EXIF.getData(input.files[0], function () {
      const allMetaData = EXIF.getAllTags(this);
      console.log(allMetaData);

      for (const key of keys) {
        eval(key).value = EXIF.getTag(this, key);
      }

      if (EXIF.getTag(this, "GPSLatitude")) {
        console.log(warning)
      } else {
        warning.style.display = "block";
      }
    });


     reader.readAsDataURL(input.files[0]);
    }

  }
}
