function [Dis,CA]=GetSweptDistance(curr_pos,next_pos,O,E,L,W,H)

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

LL1=(RA*e1+curr_pos');
LL2=(RA*e2+curr_pos');
LL3=(RA*e3+curr_pos');
LL4=(RA*e4+curr_pos');
LL5=(RA*e5+curr_pos');
LL6=(RA*e6+curr_pos');
LL7=(RA*e7+curr_pos');
LL8=(RA*e8+curr_pos');

LL1n=(RA*e1+next_pos');%next
LL2n=(RA*e2+next_pos');
LL3n=(RA*e3+next_pos');
LL4n=(RA*e4+next_pos');
LL5n=(RA*e5+next_pos');
LL6n=(RA*e6+next_pos');
LL7n=(RA*e7+next_pos');
LL8n=(RA*e8+next_pos');



CA1=[P1 LL1 LL1n];% 绳索当前位置
CA2=[P2 LL2 LL2n];
CA3=[P3 LL3 LL3n];
CA4=[P4 LL4 LL4n];
CA5=[P5 LL5 LL5n];
CA6=[P6 LL6 LL6n];
CA7=[P7 LL7 LL7n];
CA8=[P8 LL8 LL8n];

CA=[CA1 CA2 CA3 CA4 CA5 CA6 CA7 CA8];

% l1=P(:,1)-NewNode'-RA*e(:,1);
% l2=P(:,2)-NewNode'-RA*e(:,2);
% l3=P(:,3)-NewNode'-RA*e(:,3);
% l4=P(:,4)-NewNode'-RA*e(:,4);
% l5=P(:,5)-NewNode'-RA*e(:,5);
% l6=P(:,6)-NewNode'-RA*e(:,6);
% l7=P(:,7)-NewNode'-RA*e(:,7);
% l8=P(:,8)-NewNode'-RA*e(:,8);

% lL1=norm(l1);
% lL2=norm(l2);
% lL3=norm(l3);
% lL4=norm(l4);
% lL5=norm(l5);
% lL6=norm(l6);
% lL7=norm(l7);
% lL8=norm(l8);
% 
% u1=l1/lL1;
% u2=l2/lL2;
% u3=l3/lL3;
% u4=l4/lL4;
% u5=l5/lL5;
% u6=l6/lL6;
% u7=l7/lL7;
% u8=l8/lL8;
% 
% U=[u1 u2 u3 u4 u5 u6 u7 u8];
% l=[l1 l2 l3 l4 l5 l6 l7 l8];
% lL=[lL1 lL2 lL3 lL4 lL5 lL6 lL7 lL8];

p1=O-[L/2 W/2 H/2];
p8=O+[L/2 W/2 H/2];
p2=p1+[L 0 0];
p3=p1+[0 W 0];
p4=p1+[0 0 H];
p5=p8-[L 0 0];
p6=p8-[0 W 0];
p7=p8-[0 0 H];
P=[p1;p2;p3;p4;p5;p6;p7;p8]'; % 障碍当前位置

ET=getEnfVertex(curr_pos,E)';
ETn=getEnfVertex(next_pos,E)';

ET_sum=[ET ETn];

dis1=openGJK(CA1,P);
dis2=openGJK(CA2,P);
dis3=openGJK(CA3,P);
dis4=openGJK(CA4,P);
dis5=openGJK(CA5,P);
dis6=openGJK(CA6,P);
dis7=openGJK(CA7,P);
dis8=openGJK(CA8,P);
dis0=openGJK(ET_sum,P);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Dis=[dis0 dis1 dis2 dis3 dis4 dis5 dis6 dis7 dis8];

end