
include <BOSL2/std.scad>

module bucket_bottom(bottom_radius, top_radius, height, thickness = 2) {
  diff("bottom_remove", "bottom_keep") {
    cyl(h=height, r1=bottom_radius, r2=top_radius) {
      tag("bottom_remove") align(TOP) down(height - thickness) cyl(h=height, r1=bottom_radius - thickness, r2=top_radius - thickness);
      align(TOP) {
        diff("ring_remove", "ring_keep") {
          cyl(h=20, r=top_radius - thickness / 2) {
            tag("ring_remove") align(TOP) down(20) cyl(h=20, r=top_radius - thickness *2);
          };

        }
      }
    }
  }
}

module bucket_top(bottom_radius, top_radius, height, thickness = 2) {
  diff("bottom_remove", "bottom_keep") {
    cyl(h=height, r2=top_radius, r1=bottom_radius) {
      tag("bottom_remove") align(TOP) down(height - thickness) cyl(h=height, r2=top_radius - thickness, r1=bottom_radius - thickness);
      align(TOP) {
        diff("ring_remove", "ring_keep") {
          cyl(h=20, r=top_radius) {
            tag("ring_remove") align(TOP) down(20) cyl(h=20, r=top_radius - thickness/2);
          };

        }
      }
    }
  }
}

module default_draw(bottom_radius=70, top_radius=80, bottom_height=200, top_height=150) {

    bucket_bottom(bottom_radius=bottom_radius, top_radius=top_radius, height=bottom_height);
    left(top_radius * 2.5) bucket_top(bottom_radius=bottom_radius, top_radius=top_radius, height=top_height);
}

default_draw(bottom_radius=40, top_radius=50);