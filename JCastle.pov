#version  3.7;
global_settings { assumed_gamma 2.2 }

#include "shapes.inc"
#include "colors.inc"
#include "textures.inc"


// Main light source
light_source { <-50.0, 100, -80.0> colour White }

// Dim side light to fill shadows
light_source { <250.0, 25.0, -100.0> colour DimGray }


camera {
   location <5.0, 5.0, -15.0>
   angle 65 
   right     x*image_width/image_height
   look_at <0, 0, 0>
}
background { color Blue }

plane {
   y, 0 // perpendicular to axis, offset
   texture {
      pigment { 
         color Green
      }
   }
}

box {
   <-1, 0, -1>, <1, 2, 1> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
   texture {
      
      pigment { 
         color <1.0, 1.0, 1.0, 0.0, 0.0> // <red, green, blue, filter, transmit>
      }
   }
}

#declare Turret = union {
   cylinder {
      <0, 0, 0>, <0, 2.25, 0>, 0.5 // center of one end, center of other end, radius
      texture {
         
         pigment { 
            color <1.0, 1.0, 1.0, 0.0, 0.0> // <red, green, blue, filter, transmit>
         }
      }
   }
   cone {
      <0, 2.25, 0>, 0.75 // <x, y, z>, center & radius of one end
      <0, 3, 0>, 0 // <x, y, z>, center & radius of the other end
      texture {
         pigment { 
            color Red
         }
      }
   }
}
object {
   Turret
   translate <1.25, 0, -1> // <x, y, z>
}

object {
   Turret
   translate <-1.25, 0, -1> // <x, y, z>
}

sphere {
   <-1, 5, 1>, 1 // <x, y, z>, radius
   texture {
      pigment { color Yellow }
   }
}