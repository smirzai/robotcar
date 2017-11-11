$fn = 30;
ow = 45 + 2;   // original width
oh = 20 + 2;   // original height
or = 8;    // transmitter radius
dr = 27;   // distance between center of transmiters
thickness = 2   ; // thickness
shr = 0.8;       // screw hole diameter
shdx = 43;    // screw hole distance x
shdy = 18;    // screw hole distance y
cw   = 11;    // crystall width
ch   = 5;     // crystall height

ph = 3;    // pins height
bt = 2;    // base thickness
bh = 10;    // base height
$fn = 30;

bhr = 2;    // base hole radius
bhd = 10;   // base holes distance
bhs = 3;    // base hole distance to the wall 

module half() {
    union() {
    difference() {
        union() {
            // main cube
            cube([ow / 2, oh, thickness]);
          
          // base   
            translate([0,  - bt, 0])
                cube([ow / 2, bt, bh]);
           rotate(a = -90, v=[0, 1, 0])
                linear_extrude(height = 2)   
                polygon(points=[
                    [thickness , 0], 
                    [bh, 0],
                    [thickness, oh - ch]]);  
          
        }
        
        // cylinder
        translate([dr / 2, oh / 2, -1]) {
            cylinder(h = thickness + 2, r = or);};
        
       // lower screw hole    
       translate([shdx / 2, (oh - shdy) / 2, 1]) 
           cylinder(h = thickness + 2, r= shr, center=true);

       // upper screw hole
       translate([shdx / 2, (oh + shdy) / 2, 1]) 
           cylinder(h = thickness + 2, r= shr, center=true);

        // crystal hole
       translate([0, 0, -1]) 
            cube([cw / 2, ch, thickness + 2]);
            
       // pin hole     
       translate([0, (oh - ph) , -2]) 
            cube([cw / 2, ph + 1, thickness + 3]);
            
        // base screw hole
       translate([bhd / 2, +1, bhr  + bhs])
            rotate(a = 90, v = [1, 0, 0]) 
                cylinder(r = bhr, h = bt + 2);

       translate([+1, -bt - 1 , thickness / 2]) {
            rotate (a = -90, v=[1, 0, 0]) 
             linear_extrude(height = bt + 2)
                polygon(points=[
                [+ow  / 2 , -oh / 2], 
                [+ow  / 2, 0],
                [-3, -10]]);
         }
                
              
       }  
    }
}

half();
mirror (v=[1, 0, 0]) half();
