#version  3.7;
global_settings { assumed_gamma 2.2 }

#include "shapes.inc"
#include "colors.inc"
#include "textures.inc"
#include "rand.inc"
#include "stones2.inc"


// Main light source
light_source { <-50.0, 100, -80.0> colour White }

// Dim side light to fill shadows
light_source { <250.0, 25.0, -100.0> colour DimGray }


#declare CamScene = camera { // Wide Angle
   location <6.0, 5.0, -13.0>
   angle 65 
   right     x*image_width/image_height
   look_at <0, 0, 0>
}
#declare CamFrontGate = camera { // Gate View
   location <2.0, 2.0, -4.0>
   angle 65 
   right     x*image_width/image_height
   look_at <0, 0.5, 0>
}
#declare CamBridge = camera { // Gate View
   location <2.0, 2.0, -4.0>
   angle 65 
   right     x*image_width/image_height
   look_at <0, 0.5, -3.5>
}
camera { CamScene }

background { color Blue }

plane {
   y, 0 // perpendicular to axis, offset
   texture {
      pigment { 
         color <0.184314, 0.7, 0.184314>
      }
   }
}

#declare Turret = union {
   cylinder {
      <0, 0, 0>, <0, 2.25, 0>, 0.5 // center of one end, center of other end, radius
      texture { T_Stone32 }
   }
   cone {
      <0, 2.25, 0>, 0.75 // <x, y, z>, center & radius of one end
      <0, 3, 0>, 0 // <x, y, z>, center & radius of the other end
      texture {
         pigment { 
            color Firebrick
         }
      }
   }
}

#declare JCastle = union {
   box {
      <-1, 0, -1>, <1, 2, 1> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
      texture { T_Stone32 }
   }

   object {
      Turret
      translate <1.25, 0, -1> // <x, y, z>
   }

   object {
      Turret
      translate <-1.25, 0, -1> // <x, y, z>
   }

   /*sphere {
      <-1, 5, 1>, 1 // <x, y, z>, radius
      texture {
         pigment { color Yellow }
      }
   }*/
}
object {
   JCastle
   translate <0, 0.5, 0>
}

#declare Hill = union {
   sphere { // Hill
      <0,0,0>, 3
      texture {
         pigment { color Green }
      }
      scale <1.0, 0.25, 1.0> // <x, y, z>
   }

   cylinder { // Moat
      <0, -0.5, 0>, <0, 0.1, 0>, 3.5 // center of one end, center of other end, radius
      texture {
         pigment { color Blue }
      }   
   }
}
object { Hill }

#declare Tree = union {
   cylinder {
      <0, 0, 0>, <0, 0.5, 0>, 0.075 // center of one end, center of other end, radius
      texture {
         pigment { color Brown }
      }
   }
   cone {
      <0, 0.5, 0>, 0.25 // <x, y, z>, center & radius of one end
      <0, 1, 0>, 0 // <x, y, z>, center & radius of the other end
      texture {
         pigment { color Green }
      }
   }
   cone {
      <0, 0.75, 0>, 0.23 // <x, y, z>, center & radius of one end
      <0, 1.25, 0>, 0 // <x, y, z>, center & radius of the other end
      texture {
         pigment { color Green }
      }
   }
   cone {
      <0, 1, 0>, 0.2 // <x, y, z>, center & radius of one end
      <0, 1.5, 0>, 0 // <x, y, z>, center & radius of the other end
      texture {
         pigment { color Green }
      }
   }
}

#declare Forest1Seed = seed(519);
#declare Forest1UpperX = -2;
#declare Forest1LowerX = -10;
#declare Forest1UpperZ = -4;
#declare Forest1LowerZ = -10;
#declare n = 0;
#while (n < 10)
   object {
      Tree
      translate VRand_In_Box(<Forest1UpperX,0,Forest1UpperZ>, <Forest1LowerX,0,Forest1LowerZ>, Forest1Seed)
   }
   #declare n = n + 1;
#end

#declare Forest2Seed = seed(77);
#declare Forest2UpperX = 2;
#declare Forest2LowerX = 10;
#declare Forest2UpperZ = -4;
#declare Forest2LowerZ = -10;
#declare n = 0;
#while (n < 10)
   object {
      Tree
      translate VRand_In_Box(<Forest2UpperX,0,Forest2UpperZ>, <Forest2LowerX,0,Forest2LowerZ>, Forest2Seed)
   }
   #declare n = n + 1;
#end

box { // Path
   <-0.5, 0, -3.75>, <0.5, 0.1, -20> // <x, y, z> near lower left corner, <x, y, z> far upper right corner
   texture { T_Stone32 }
}

// Clouds
#declare Cloud = merge {
   sphere {
      <0, 0, 0>, 1 // <x, y, z>, radius
      texture {
         pigment { 
            color rgbf <1,1,1,0.35>
         }
      }
      scale <1,0.85,1>
   }
   sphere {
      <0, 0, 0>, 1 // <x, y, z>, radius
      texture {
         pigment { 
            color rgbf <1,1,1,0.35>
         }
      }
      scale <0.75,1,0.65>
      translate <-0.7, 0.2, 0> // <x, y, z>
   }
}
object {
   Cloud
   translate <0, 5, 0> // <x, y, z>
}