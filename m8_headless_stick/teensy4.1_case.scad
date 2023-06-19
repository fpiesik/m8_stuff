wC=18;  // width oft the combined connectors
dC=61.2; //depth of the combined connectors
hC=13.5; //height of the cobined connectors

wE=10; //width of the rj45 connector
hE=5; //height of the rj45 connector

wT=1.5;  //wall thickness
btmT=1;

wI=wC; //width inside
wO=wI+wT*2; //width outside

dI=dC;  //depth inside
dO=dI+btmT; //depth outside

hI=hC;  //height inside
hO=hI+wT*2; //height outside

wU=12.2;  //width of the usb-c connector
hU=4.7;  //height of the usc-c connector
uOff=2;

wS=12.3;  //width of the usb-c connector
hS=3.5;  //height of the usc-c connector
sOff=0;

eR=2; //edge radius
t=0; //tolerance of the lid
lD=3; //depth of the lid

grillT=1.6;
grillS=3.5;
grillW=wC-wT*2;
grillH=dC-5;

base();
translate([0,30,wT+dO])rotate([0,180,0])lid();

module lid(){
  translate([0,0,dO]){  
    difference(){
      union(){
        rcube([wO,hO,wT],eR);
        translate([0,0,-lD])rcube([wI-t,hI-t,lD],0.1);
      }
      tD=3.5;
      tUD=3.2;
      tUW=9;
      ucWA=8.5;
      ucWB=11.5;
      ucD=2.7;
      translate([0,hC/2-tD/2-tUD,-lD])rcube([wI,tD,lD],0.1);
      translate([0,hC/2-tUD/2-0.3,-6])rcube([tUW,tUD+0.6,12],0.1);
      
      translate([0,-(hC/2-ucD/2),-6])rcube([ucWA,ucD,10],0.1);
      translate([0,-(hC/2-ucD/2),-lD])rcube([ucWB,ucD,lD],0.1);
    }
  }
}

module base(){
  difference(){
    rcube([wO,hO,dO],eR);
    translate([0,0,btmT])rcube([wI,hI,dI+1],0.1);
    translate([0,hI/2-hU/2-uOff,-1])rcube([wU,hU,wT+2],0.1);
    translate([0,-(hI/2-hS/2-sOff),-1])rcube([wS,hS,wT+2],0.1);
    translate([0,wT*2-(hC/2+2),dO/2])rotate([90,0,0])rcube([grillW,grillH,wT*2],eR);
    }
   for(i= [0 : grillS: grillH]){
    translate([-grillW/2,-(hC/2)-wT,dO/2-grillH/2+i-grillT/2])cube([grillW,wT,grillT]);
   }
   translate([-grillT/2,-(hC/2)-wT,dO/2-grillH/2])cube([grillT,wT,grillH]);
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