
include <BOSL2/std.scad>
$fn = 60;

module ring(inner_radius, outer_radius, thickness, height, anchor=CENTER, spin=0, orient=UP) {

  assert(num_defined(inner_radius) || num_defined(outer_radius), "Define one of the radius values");
  assert(!(num_defined(inner_radius) && num_defined(outer_radius) && num_defined(thickness)), "Don't define thickness if you define both radius values");

  local_inner_radius = inner_radius ? inner_radius : outer_radius - thickness;  
  local_outer_radius = outer_radius ? outer_radius : inner_radius + thickness;


  attachable(anchor, spin, orient, r = outer_radius, l = height) {
    tag_scope() {
      diff() {
      cyl(h=height, r=local_outer_radius) {
          tag("remove") align(TOP) down(height) cyl(h=height, r=local_inner_radius);
        }
      } 
    } children();
  }
}

module bucket_bottom(bottom_radius, top_radius, height, thickness = 2) {
  diff("bottom_remove", "bottom_keep") {
    cyl(h=height, r1=bottom_radius, r2=top_radius, rounding1=5) {
      tag("bottom_remove") align(TOP) down(height - thickness) cyl(h=height, r1=bottom_radius - thickness, r2=top_radius - thickness);
      align(TOP) {
        
        up(10) ring(inner_radius=top_radius - thickness, thickness=thickness/2 -0.25, height=20) align(TOP) {
            align(TOP) down(10) cuboid([top_radius * 2 - thickness - 0.50, thickness, 20]);
            align(TOP) zrot(90) down(10) cuboid([top_radius * 2 - thickness - 0.50, thickness, 20]);

        }
      }
      tag("bottom_keep") align(TOP) down(height - thickness) prismoid(size2=[top_radius * 2 - thickness - 0.50, thickness], size1=[bottom_radius * 2 - thickness - 0.25, thickness], h=height);
      tag("bottom_keep") align(TOP) zrot(90) down(height - thickness) prismoid(size2=[top_radius * 2 - thickness - 0.50, thickness], size1=[bottom_radius * 2 - thickness - 0.25, thickness], h=height);
    }
  }
}

module bucket_top(bottom_radius, top_radius, height, thickness = 2) {
  diff("bottom_remove", "bottom_keep") {
    cyl(h=height, r2=top_radius, r1=bottom_radius, rounding1=5) {
      tag("bottom_remove") align(TOP) down(height - thickness) cyl(h=height, r2=top_radius - thickness, r1=bottom_radius - thickness);
      align(TOP) {
        ring(outer_radius=top_radius, thickness=thickness/2 -0.25, height=20);
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

//ring(outer_radius=80, thickness=3, height=20) show_anchors();