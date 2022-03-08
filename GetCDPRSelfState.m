function [U,l,lL,J,fcf,Dis,nonKMoterv,KMoterv]=GetCDPRSelfState(NewNode,maxForce,E,O,L,W,H)

P1=[-437.082 524.3283 864.7443]';
P2=[439.7277 525.9461 860.8701]';
P3=[-435.143 -521.906 839.1691]';
P4=[437.8987 -523.83 859.4645]';
P5=[-535.048 466.8895 79.72492]';
P6=[531.9962 451.4305 80.32775]';
P7=[-543.043 -463.811 71.49693]';
P8=[529.0567 -448.63 84.36402]';

e1=[-130/2,130/2,-130/2]';
e2=[130/2,130/2,-130/2]';
e3=[-130/2,-130/2,-130/2]';
e4=[130/2,-130/2,-130/2]';
e5=[-130/2,130/2,130/2]';
e6=[130/2,130/2,130/2]';
e7=[-130/2,-130/2,130/2]';
e8=[130/2,-130/2,130/2]';

x1= -pi/180*0;
x2=-pi/180*0;
x3=pi/180*0;



P=[P1 P2 P3 P4 P5 P6 P7 P8];
e=[e1 e2 e3 e4 e5 e6 e7 e8];

RA=[cos(x3)*cos(x2),-sin(x3)*cos(x1)+cos(x3)*sin(x2)*sin(x1),sin(x3)*sin(x1)+cos(x3)*sin(x2)*cos(x1);
    cos(x2)*sin(x3),cos(x1)*cos(x3)+sin(x1)*sin(x2)*sin(x3),-cos(x3)*sin(x1)+cos(x1)*sin(x2)*sin(x3);-sin(x2),cos(x2)*sin(x1),cos(x1)*cos(x2)];

LL1=(RA*e1+NewNode');
LL2=(RA*e2+NewNode');
LL3=(RA*e3+NewNode');
LL4=(RA*e4+NewNode');
LL5=(RA*e5+NewNode');
LL6=(RA*e6+NewNode');
LL7=(RA*e7+NewNode');
LL8=(RA*e8+NewNode');

CA1=[P1 LL1];% 绳索当前位置
CA2=[P2 LL2];
CA3=[P3 LL3];
CA4=[P4 LL4];
CA5=[P5 LL5];
CA6=[P6 LL6];
CA7=[P7 LL7];
CA8=[P8 LL8];

CA=[CA1 CA2 CA3 CA4 CA5 CA6 CA7 CA8];

l1=P(:,1)-NewNode'-RA*e(:,1);
l2=P(:,2)-NewNode'-RA*e(:,2);
l3=P(:,3)-NewNode'-RA*e(:,3);
l4=P(:,4)-NewNode'-RA*e(:,4);
l5=P(:,5)-NewNode'-RA*e(:,5);
l6=P(:,6)-NewNode'-RA*e(:,6);
l7=P(:,7)-NewNode'-RA*e(:,7);
l8=P(:,8)-NewNode'-RA*e(:,8);

lL1=norm(l1);
lL2=norm(l2);
lL3=norm(l3);
lL4=norm(l4);
lL5=norm(l5);
lL6=norm(l6);
lL7=norm(l7);
lL8=norm(l8);

u1=l1/lL1;
u2=l2/lL2;
u3=l3/lL3;
u4=l4/lL4;
u5=l5/lL5;
u6=l6/lL6;
u7=l7/lL7;
u8=l8/lL8;

M1=cross(RA*e1,u1);
M2=cross(RA*e2,u2);
M3=cross(RA*e3,u3);
M4=cross(RA*e4,u4);
M5=cross(RA*e5,u5);
M6=cross(RA*e6,u6);
M7=cross(RA*e7,u7);
M8=cross(RA*e8,u8);
M=[M1 M2 M3 M4 M5 M6 M7 M8];



U=[u1 u2 u3 u4 u5 u6 u7 u8]; % 绳索单位向量
l=[l1 l2 l3 l4 l5 l6 l7 l8]; % 绳索向量
lL=[lL1 lL2 lL3 lL4 lL5 lL6 lL7 lL8]; % 绳索长度
J=[U;M];
Wg=[0 0 0 0 0 -1.2*9.8]';
fref=[maxForce/2 maxForce/2 maxForce/2 maxForce/2 maxForce/2 maxForce/2 maxForce/2 maxForce/2]';

fcf=fref-pinv(J)*Wg-pinv(J)*J*fref;

if ~isempty(L) || ~isempty(W) || ~isempty(H)
    Dis=dGetDistance(NewNode,E,O,L,W,H);
else
    Dis=[];
end
    
[a1 a2 a3 a4 a5 a6 a7 a8]=kinematicsPF(NewNode(1),NewNode(2),NewNode(3));
nonKMoterv=[a1 a2 a3 a4 a5 a6 a7 a8];

[L1I L2I L3I L4I L5I L6I L7I L8I]=kinematicsIN(NewNode(1),NewNode(2),NewNode(3));

YoungE=120;  % Gpa 杨氏模量
Area=pi*1.5^2;

sK=10^3*diag([(YoungE*Area)/L1I (YoungE*Area)/L2I (YoungE*Area)/L3I (YoungE*Area)/L4I (YoungE*Area)/L5I (YoungE*Area)/L6I (YoungE*Area)/L7I (YoungE*Area)/L8I]);  % 刚度为 N/mm
realL=sK\fcf+[L1I L2I L3I L4I L5I L6I L7I L8I]';


[temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8]=kinematicsIN(0,0,445);
ini=[temp1,temp2,temp3,temp4,temp5,temp6,temp7,temp8];

aa1 = round(-(((realL(1)-ini(1))*360)/((pi*64)+5)),3);
aa2 = round(-(((realL(2)-ini(2))*360)/((pi*64)+5)),3);
aa3 = round(-(((realL(3)-ini(3))*360)/((pi*64)+5)),3);
aa4 = round(-(((realL(4)-ini(4))*360)/((pi*64)+5)),3);
aa5 = round(-(((realL(5)-ini(5))*360)/((pi*64)+5)),3);
aa6 = round(-(((realL(6)-ini(6))*360)/((pi*64)+5)),3);
aa7 = round(-(((realL(7)-ini(7))*360)/((pi*64)+5)),3);
aa8 = round(-(((realL(8)-ini(8))*360)/((pi*64)+5)),3);

KMoterv=[aa1 aa2 aa3 aa4 aa5 aa6 aa7 aa8];

end

