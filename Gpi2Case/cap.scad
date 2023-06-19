capR=11;
capRB=2;
capH=37.5;
capW=81;
wT=1.9;

teensyW=18;
chrgW=19.3;
//donut();
grillT=1.6;
grillS=3.4;
grillW=capW-capR*2;
grillH=capH-capR;

difference(){
  $fn=64;
  hull(){
    translate([capW/2-capR,0,capRB])cylinder(r=capR, h=capH-capRB);
    translate([-(capW/2-capR),0,capRB])cylinder(r=capR, h=capH-capRB);
    translate([(capW/2-capR),0,capRB])donut();
    translate([-(capW/2-capR),0,capRB])donut();
  }
    hull(){
    translate([capW/2-capR,0,wT])cylinder(r=capR-wT, h=capH+2);
    translate([-(capW/2-capR),0,wT])cylinder(r=capR-wT, h=capH+2);
  }
  
  translate([-capW/2,0,-1])cube([capW,capH,capH+2]);
  translate([0,0,capH])negCyl();
  
  translate([0,0,capH/2])rotate([90,0,0])rcube([capW-capR*2,capH-capR,100],capRB);

  translate([0,-capR/2,-1])rotate([0,0,0])rcube([capW-capR*2,capR/2,100],capRB);
 
  translate([capW/2,0,chrgW/2+wT+2])rotate([90,0,0])rcube([capW-capR*2,10,9],capRB);
  translate([-capW/2,-3,chrgW/2+wT/2])rotate([90,0,0])rcube([capW-capR*2,16,6],capRB);
  
}
   for(i= [0 : grillS: grillW/2]){
      translate([i-grillT/2,-capR,capH/2-grillH/2])cube([grillT,wT,grillH]);
      translate([-i-grillT/2,-capR,capH/2-grillH/2])cube([grillT,wT,grillH]);
    }
    
   for(i= [0 : grillS: grillW/2]){
      translate([i-grillT/2,-capR+capRB,0])cube([grillT,capR-capRB,wT]);
      translate([-i-grillT/2,-capR+capRB,0])cube([grillT,capR-capRB,wT]);
    }
    
    translate([-grillW/2,-capR,wT+teensyW])cube([grillW,wT,grillT]);
    translate([6.5,-capR+wT,wT+teensyW])cube([grillW/2,capR-wT*2,grillT]);
    translate([-3.5,(-capR+wT),wT*2+teensyW])rotate([0,180,0])cube([grillW/2+2.5,capR-wT*2,grillT]);

module donut(){
  $fa = 1;
  $fs = 0.4;
  wheel_radius = capR;
  tyre_radius = capRB;
  rotate_extrude(angle=360) {
  translate([wheel_radius - tyre_radius, 0])circle(r=tyre_radius);
  }
}

module negCyl(){
  r=capRB;
  w=capW;
  $fn=16;
  difference(){
    cube([w,r*2,r*2],center=true);
    translate([0,-r,-r])rotate([0,90,0])cylinder(r=r,h=w+2,center=true);
  }
}

module rcube(size,radius){
  $fn=16;
  linear_extrude(height=size[2])
  if(radius>0){
  hull()
  {
      // place 4 circles in the corners, with the given radius
      translate([(-size[0]/2)+(radius), (-size[1]/2)+(radius), 0])
      circle(r=radius);

      translate([(size[0]/2)-(radius), (-size[1]/2)+(radius), 0])
      circle(r=radius);

      translate([(-size[0]/2)+(radius), (size[1]/2)-(radius), 0])
      circle(r=radius);

      translate([(size[0]/2)-(radius), (size[1]/2)-(radius), 0])
      circle(r=radius);
  }
  }
  if(radius==0){
    translate([0,0,size[2]/2])cube(size,center=true);
  }
}