clear 
clc
%test convex hull distrbution

C=[];
max_av=2.9587e+07;
min_av=2.6388e+07;
max_avi=3.7881e-08; %倒数
min_avi=3.3804e-08;
P1=[-437.082 524.3283 864.7443]';  
P2=[439.7277 525.9461 860.8701]';       %%           
P3=[-435.143 -521.906 839.1691]';        %%
P4=[437.8987 -523.83 859.4645]';         %%
P5=[-535.048 466.8895 79.72492]';        %%
P6=[531.9962 451.4305 80.32775]';         %%
P7=[-543.043 -463.811 71.49693]';         %%
P8=[529.0567 -448.63 84.36402]';  

e1=[-130/2,130/2,-130/2]';
e2=[130/2,130/2,-130/2]';
e3=[-130/2,-130/2,-130/2]';
e4=[130/2,-130/2,-130/2]';
e5=[-130/2,130/2,130/2]';
e6=[130/2,130/2,130/2]';
e7=[-130/2,-130/2,130/2]';
e8=[130/2,-130/2,130/2]';

AA=ff2n(8)';
C1=[];
C2=[];%Normalized 
C3=[];
C4=[];

%G=[x y z]';
for x=-200:20:200
    for y=-200:20:200
        for z=445
G=[x y z]';
W=[0 0 0 0 0 -1*9.8]';

x1=0;
x2=0;
x3=0;

RA=[cos(x3)*cos(x2),-sin(x3)*cos(x1)+cos(x3)*sin(x2)*sin(x1),sin(x3)*sin(x1)+cos(x3)*sin(x2)*cos(x1);
cos(x2)*sin(x3),cos(x1)*cos(x3)+sin(x1)*sin(x2)*sin(x3),-cos(x3)*sin(x1)+cos(x1)*sin(x2)*sin(x3);-sin(x2),cos(x2)*sin(x1),cos(x1)*cos(x2)];

L1ve=P1-RA*e1-G; %% PONIT B  posion relative to fame KA 
L2ve=P2-RA*e2-G;
L3ve=P3-RA*e3-G;
L4ve=P4-RA*e4-G;
L5ve=P5-RA*e5-G;
L6ve=P6-RA*e6-G;
L7ve=P7-RA*e7-G;
L8ve=P8-RA*e8-G;

bxy1p=sqrt((L1ve(1)^2)+(L1ve(2)^2));% length of bxy 
bxy2p=sqrt((L2ve(1)^2)+(L2ve(2)^2));
bxy3p=sqrt((L3ve(1)^2)+(L3ve(2)^2));
bxy4p=sqrt((L4ve(1)^2)+(L4ve(2)^2));
bxy5p=sqrt((L5ve(1)^2)+(L5ve(2)^2));
bxy6p=sqrt((L6ve(1)^2)+(L6ve(2)^2));
bxy7p=sqrt((L7ve(1)^2)+(L7ve(2)^2));
bxy8p=sqrt((L8ve(1)^2)+(L8ve(2)^2));



rp=[13,13,13,13,13,13,13,13];

bxy1=bxy1p-rp(1);
bxy2=bxy2p-rp(2);
bxy3=bxy3p-rp(3);
bxy4=bxy4p-rp(4);
bxy5=bxy5p-rp(5);
bxy6=bxy6p-rp(6);
bxy7=bxy7p-rp(7);
bxy8=bxy8p-rp(8);

bz1=L1ve(3);
bz2=L2ve(3);
bz3=L3ve(3);
bz4=L4ve(3);
bz5=L5ve(3);
bz6=L6ve(3);
bz7=L7ve(3);
bz8=L8ve(3);

MB1=sqrt((bxy1^2)+(bz1^2));
MB2=sqrt((bxy2^2)+(bz2^2));
MB3=sqrt((bxy3^2)+(bz3^2));
MB4=sqrt((bxy4^2)+(bz4^2));
MB5=sqrt((bxy5^2)+(bz5^2));
MB6=sqrt((bxy6^2)+(bz6^2));
MB7=sqrt((bxy7^2)+(bz7^2));
MB8=sqrt((bxy8^2)+(bz8^2));

lf(1)=sqrt((MB1^2)-(rp(1)^2));
lf(2)=sqrt((MB2^2)-(rp(2)^2));
lf(3)=sqrt((MB3^2)-(rp(3)^2));
lf(4)=sqrt((MB4^2)-(rp(4)^2));
lf(5)=sqrt((MB5^2)-(rp(5)^2));
lf(6)=sqrt((MB6^2)-(rp(6)^2));
lf(7)=sqrt((MB7^2)-(rp(7)^2));
lf(8)=sqrt((MB8^2)-(rp(8)^2));

beta(1)=acos(lf(1)/sqrt((bxy1^2)+(bz1^2)))+acos(bz1/(sqrt((bxy1^2)+bz1^2)));
beta(2)=acos(lf(2)/sqrt((bxy2^2)+(bz2^2)))+acos(bz2/(sqrt((bxy2^2)+bz2^2)));
beta(3)=acos(lf(3)/sqrt((bxy3^2)+(bz3^2)))+acos(bz3/(sqrt((bxy3^2)+bz3^2)));
beta(4)=acos(lf(4)/sqrt((bxy4^2)+(bz4^2)))+acos(bz4/(sqrt((bxy4^2)+bz4^2)));
beta(5)=acos(lf(5)/sqrt((bxy5^2)+(bz5^2)))+acos(bz5/(sqrt((bxy5^2)+bz5^2)));
beta(6)=acos(lf(6)/sqrt((bxy6^2)+(bz6^2)))+acos(bz6/(sqrt((bxy6^2)+bz6^2)));
beta(7)=acos(lf(7)/sqrt((bxy7^2)+(bz7^2)))+acos(bz7/(sqrt((bxy7^2)+bz7^2)));
beta(8)=acos(lf(8)/sqrt((bxy8^2)+(bz8^2)))+acos(bz8/(sqrt((bxy8^2)+bz8^2)));

% gama(1)=0;
% gama(2)=0;
% gama(3)=0;
% gama(4)=0;
% gama(5)=0;
% gama(6)=0;
% gama(7)=0;
% gama(8)=0;

gama(1)=atan2(L1ve(2),L1ve(1));
gama(2)=atan2(L2ve(2),L2ve(1));
gama(3)=atan2(L3ve(2),L3ve(1));
gama(4)=atan2(L4ve(2),L4ve(1));
gama(5)=atan2(L5ve(2),L5ve(1));
gama(6)=atan2(L6ve(2),L6ve(1));
gama(7)=atan2(L7ve(2),L7ve(1));
gama(8)=atan2(L8ve(2),L8ve(1));

RZ1=[cos(gama(1)) -sin(gama(1)) 0;sin(gama(1)) cos(gama(1)) 0;0 0 1];
RZ2=[cos(gama(2)) -sin(gama(2)) 0;sin(gama(2)) cos(gama(2)) 0;0 0 1];
RZ3=[cos(gama(3)) -sin(gama(3)) 0;sin(gama(3)) cos(gama(3)) 0;0 0 1];
RZ4=[cos(gama(4)) -sin(gama(4)) 0;sin(gama(4)) cos(gama(4)) 0;0 0 1];
RZ5=[cos(gama(5)) -sin(gama(5)) 0;sin(gama(5)) cos(gama(5)) 0;0 0 1];
RZ6=[cos(gama(6)) -sin(gama(6)) 0;sin(gama(6)) cos(gama(6)) 0;0 0 1];
RZ7=[cos(gama(7)) -sin(gama(7)) 0;sin(gama(7)) cos(gama(7)) 0;0 0 1];
RZ8=[cos(gama(8)) -sin(gama(8)) 0;sin(gama(8)) cos(gama(8)) 0;0 0 1];

RY1=[cos(beta(1)) 0 sin(beta(1));0 1 0;-sin(beta(1)) 0 cos(beta(1))];
RY2=[cos(beta(2)) 0 sin(beta(2));0 1 0;-sin(beta(2)) 0 cos(beta(2))];
RY3=[cos(beta(3)) 0 sin(beta(3));0 1 0;-sin(beta(3)) 0 cos(beta(3))];
RY4=[cos(beta(4)) 0 sin(beta(4));0 1 0;-sin(beta(4)) 0 cos(beta(4))];
RY5=[cos(beta(5)) 0 sin(beta(5));0 1 0;-sin(beta(5)) 0 cos(beta(5))];
RY6=[cos(beta(6)) 0 sin(beta(6));0 1 0;-sin(beta(6)) 0 cos(beta(6))];
RY7=[cos(beta(7)) 0 sin(beta(7));0 1 0;-sin(beta(7)) 0 cos(beta(7))];
RY8=[cos(beta(8)) 0 sin(beta(8));0 1 0;-sin(beta(8)) 0 cos(beta(8))];

I=[1 0 0;0 1 0;0 0 1];

c1=P1+RA*(RZ1*((I-RY1)*[13,0,0]'));% real cable outgoing point veter
c2=P2+RA*(RZ2*((I-RY2)*[13,0,0]'));
c3=P3+RA*(RZ3*((I-RY3)*[13,0,0]'));
c4=P4+RA*(RZ4*((I-RY4)*[13,0,0]'));
c5=P5+RA*(RZ5*((I-RY5)*[13,0,0]'));
c6=P6+RA*(RZ6*((I-RY6)*[13,0,0]'));
c7=P7+RA*(RZ7*((I-RY7)*[13,0,0]'));
c8=P8+RA*(RZ8*((I-RY8)*[13,0,0]'));

l1=c1-G-RA*e1;
l2=c2-G-RA*e2;
l3=c3-G-RA*e3;
l4=c4-G-RA*e4;
l5=c5-G-RA*e5;
l6=c6-G-RA*e6;
l7=c7-G-RA*e7;
l8=c8-G-RA*e8;

L1=norm(l1);
L2=norm(l2);
L3=norm(l3);
L4=norm(l4);
L5=norm(l5);
L6=norm(l6);
L7=norm(l7);
L8=norm(l8);

u1=l1/L1;
u2=l2/L2;
u3=l3/L3;
u4=l4/L4;
u5=l5/L5;
u6=l6/L6;
u7=l7/L7;
u8=l8/L8;

M1=cross(RA*e1,u1);
M2=cross(RA*e2,u2);
M3=cross(RA*e3,u3);
M4=cross(RA*e4,u4);
M5=cross(RA*e5,u5);
M6=cross(RA*e6,u6);
M7=cross(RA*e7,u7);
M8=cross(RA*e8,u8);

U=[u1 u2 u3 u4 u5 u6 u7 u8];
M=[M1 M2 M3 M4 M5 M6 M7 M8];
J=[U;M];
JG=[J W];
detaT=100;
di=diag([detaT detaT detaT detaT detaT detaT detaT detaT]);
MW=U*di; % M matrix in paper
A_alpha=MW*AA;
A_alphaT=A_alpha';
[k2,av2] = convhull(A_alphaT(:,1),A_alphaT(:,2),A_alphaT(:,3),'Simplify',true);
C1=[C1;x y z av2];
C2=[C2;x y z (av2-min_av)/(max_av-min_av)];
C3=[C3;x y z 1/av2];
C4=[C4;x y z ((1/av2)-min_avi)/(max_avi-min_avi)];
        end
    end
end
%trisurf(k2,A_alphaT(:,1),A_alphaT(:,2),A_alphaT(:,3),'FaceColor','cyan');

%V1=[0 0;80 0; 50 80;0 90]';

% VV=[V1; V2; V3; V4];
% V=[VV;VV;VV;VV];

%V=blkdiag(V1,V1,V1,V1);
%MA=J*V;
%MA1=MA(1:3,:);
%MA1=MA1';

% [k3,av3] = convhull(MA1(:,1),MA1(:,2),MA1(:,3),'Simplify',true);
% trisurf(k3,MA1(:,1),MA1(:,2),MA1(:,3),'FaceColor','cyan');