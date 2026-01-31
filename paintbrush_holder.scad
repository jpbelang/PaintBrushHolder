
include <BOSL2/std.scad>
$fn = 60;

module bucket_bottom(bottom_radius, top_radius, height, thickness = 2) {
  diff("bottom_remove", "bottom_keep") {
    cyl(h=height, r1=bottom_radius, r2=top_radius, rounding1=5) {
      tag("bottom_remove") align(TOP) down(height - thickness) cyl(h=height, r1=bottom_radius - thickness, r2=top_radius - thickness);
      align(TOP) {
        diff("ring_remove", "ring_keep") {
          cyl(h=20, r=top_radius - thickness / 2) {
            tag("ring_remove") align(TOP) down(20) cyl(h=20, r=top_radius - thickness );

            tag("ring_keep") align(TOP) down(20) cuboid([top_radius * 2 - thickness - 0.25, thickness, 20]);
            tag("ring_keep") align(TOP) zrot(90) down(20) cuboid([top_radius * 2 - thickness - 0.25, thickness, 20]);

          }; 
         
        }
      }
      tag("bottom_keep") align(TOP) down(height - thickness) prismoid(size2=[top_radius * 2 - thickness - 0.25, thickness], size1=[bottom_radius * 2 - thickness - 0.25, thickness], h=height);
      tag("bottom_keep") align(TOP) zrot(90) down(height - thickness) prismoid(size2=[top_radius * 2 - thickness - 0.25, thickness], size1=[bottom_radius * 2 - thickness - 0.25, thickness], h=height);
    }
  }
}

module bucket_top(bottom_radius, top_radius, height, thickness = 2) {
  diff("bottom_remove", "bottom_keep") {
    cyl(h=height, r2=top_radius, r1=bottom_radius, rounding1=5) {
      tag("bottom_remove") align(TOP) down(height - thickness) cyl(h=height, r2=top_radius - thickness, r1=bottom_radius - thickness);
      align(TOP) {
        diff("ring_remove", "ring_keep") {
          cyl(h=20, r=top_radius) {
            tag("ring_remove") align(TOP) down(20) cyl(h=20, r=top_radius - thickness/2);
          };

        }
      }


    
      tag("bottom_remove") {    
        align(TOP) xrot(-40) yrot(30) down(300)  cyl(h=300, r=5);
        align(TOP) xrot(-20) yrot(30) down(300)  cyl(h=300, r=5);
        align(TOP) xrot(0) yrot(30) down(300)  cyl(h=300, r=5);
        align(TOP) xrot(20) yrot(30) down(300)  cyl(h=300, r=5);
        align(TOP) xrot(40) yrot(30) down(300)  cyl(h=300, r=5);

        align(TOP) xrot(-40) yrot(-30) down(300)  cyl(h=300, r=5);
        align(TOP) xrot(-20) yrot(-30) down(300)  cyl(h=300, r=5);
        align(TOP) xrot(0) yrot(-30) down(300)  cyl(h=300, r=5);
        align(TOP) xrot(20) yrot(-30) down(300)  cyl(h=300, r=5);
        align(TOP) xrot(40) yrot(-30) down(300)  cyl(h=300, r=5);
      }
    }
  }
}

module default_draw(bottom_radius=70, top_radius=80, bottom_height=200, top_height=150, thickness=3) {

    bucket_bottom(bottom_radius=bottom_radius, top_radius=top_radius, height=bottom_height, thickness=thickness);
    left(top_radius * 2.5) bucket_top(bottom_radius=bottom_radius, top_radius=top_radius, height=top_height, thickness=thickness);
}

default_draw();