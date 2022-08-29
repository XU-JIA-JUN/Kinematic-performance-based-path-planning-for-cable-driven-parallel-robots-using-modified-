%MITE paper 自适应


close all
clc
clf


P1=[-437.082 524.3283 864.7443]';
P2=[439.7277 525.9461 860.8701]';
P3=[-435.143 -521.906 839.1691]';
P4=[437.8987 -523.83 859.4645]';
P5=[-535.048 466.8895 79.72492]';
P6=[531.9962 451.4305 80.32775]';
P7=[-543.043 -463.811 71.49693]';
P8=[529.0567 -448.63 84.36402]';
PT=[P1'; P2'; P3'; P4'; P5'; P6'; P7'; P8'];
e1=[-130/2,130/2,-130/2]';
e2=[130/2,130/2,-130/2]';
e3=[-130/2,-130/2,-130/2]';
e4=[130/2,-130/2,-130/2]';
e5=[-130/2,130/2,130/2]';
e6=[130/2,130/2,130/2]';
e7=[-130/2,-130/2,130/2]';
e8=[130/2,-130/2,130/2]';
ET=[e1'; e2' ;e3' ;e4' ;e5' ;e6' ;e7' ;e8'];
x1= -pi/180*0;
x2=-pi/180*0;
x3=pi/180*0;
P=[P1 P2 P3 P4 P5 P6 P7 P8];
e=[e1 e2 e3 e4 e5 e6 e7 e8];

RA=[cos(x3)*cos(x2),-sin(x3)*cos(x1)+cos(x3)*sin(x2)*sin(x1),sin(x3)*sin(x1)+cos(x3)*sin(x2)*cos(x1);
    cos(x2)*sin(x3),cos(x1)*cos(x3)+sin(x1)*sin(x2)*sin(x3),-cos(x3)*sin(x1)+cos(x1)*sin(x2)*sin(x3);-sin(x2),cos(x2)*sin(x1),cos(x1)*cos(x2)];


figure(1003)
clf
h = gca;
axis([-600 600 -600 600 0 1000])
set(gca,'nextplot','replacechildren','box','off','color','w','xgrid','off')
hold on;
kx=[P7(1) P8(1) P4(1) P3(1) P7(1) P3(1) P1(1) P5(1) P7(1) P5(1) P1(1) P2(1) P6(1) P8(1) P4(1) P2(1) P6(1) P6(1) P5(1)];
ky=[P7(2) P8(2) P4(2) P3(2) P7(2) P3(2) P1(2) P5(2) P7(2) P5(2) P1(2) P2(2) P6(2) P8(2) P4(2) P2(2) P6(2) P6(2) P5(2)];
kz=[P7(3) P8(3) P4(3) P3(3) P7(3) P3(3) P1(3) P5(3) P7(3) P5(3) P1(3) P2(3) P6(3) P8(3) P4(3) P2(3) P6(3) P6(3) P5(3)];
plot3(kx,ky,kz,'r','linewidth',2);

text(P1(1),P1(2),P1(3),'A1','FontSize',10)
text(P2(1),P2(2),P2(3),'A2','FontSize',10)
text(P3(1),P3(2),P3(3),'A3','FontSize',10)
text(P4(1),P4(2),P4(3),'A4','FontSize',10)
text(P5(1),P5(2),P5(3),'A5','FontSize',10)
text(P6(1),P6(2),P6(3),'A6','FontSize',10)
text(P7(1),P7(2),P7(3),'A7','FontSize',10)
text(P8(1),P8(2),P8(3),'A8','FontSize',10)
%view(-28,20)
view(-112,21)
%set(gcf,'Position',[20 20 1200 1200])
hold on
%%%%%%%%%%%
%  L1=220;L2=80; % 2个障碍物
%  W1=125;W2=80;
%  H1=350;H2=450;
%  obs_pos1=[200 -150 H1/2];obs_pos2=[-150 0 H2/2];
%  obs_list=[L1 W1 H1 obs_pos1;L2 W2 H2 obs_pos2];
%%%%%%%%%%%%%%%%%%%%%
%  L2=80; % 1个障碍物
%  W2=80;
%  H2=450;
%  obs_pos2=[-150 0 H2/2];
%  obs_list=[L2 W2 H2 obs_pos2];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 L1=220;L2=80; L3=220;% 3个障碍物
 W1=125;W2=80; W3=125;
 H1=350;H2=450;H3=420;
 obs_pos1=[200 -150 H1/2];obs_pos2=[-150 0 H2/2];obs_pos3=[-200 200 H3/2];
 obs_list=[L1 W1 H1 obs_pos1;L2 W2 H2 obs_pos2;L3 W3 H3 obs_pos3];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start_pos=[180 180 300];
[cab1, cab2, cab3, cab4, cab5, cab6, cab7, cab8, cube] = eplot(start_pos);
goal_pos=[-180 -180 380];
E=130;
step_size=40;
dg=50;
ball_radius=80;
count=1;
bg=10;
%%%%%
o_efr=0;
maxCostNode_pos=start_pos;
mostFaiure_pos=start_pos;
%%%%%
[collision,BestDis]=checkDis(start_pos,start_pos,obs_list);
if collision
    %error('起始点不可行')
else
    Tree.nodes(1).pos=start_pos;% 初始位置
    Tree.nodes(1).indPrev=0; %父节点索引
    Tree.nodes(1).dis_cost=0;
    Tree.nodes(1).real_cost=getConHullCost(start_pos');
    Tree.nodes(1).BestDis=BestDis;
    Tree.nodes(1).faiureNum=0;
    Tree.nodes(1).extendNum=0.0001;
    Tree.nodes(1).o_efr=Tree.nodes(1).faiureNum/Tree.nodes(1).extendNum;
end
%%%%%%%%%%%%%%%%
u_z=[0 0 1];
u_new_z=(goal_pos-start_pos)/norm(goal_pos-start_pos);
sita=acos(dot(u_z,u_new_z));
n_v=cross(u_z,u_new_z);
n_v_invert=[0 -n_v(3) n_v(2);n_v(3) 0 -n_v(1); -n_v(2) n_v(1) 0];
I=eye(3);
R1=I+sin(sita)*n_v_invert+(1-cos(sita))*n_v_invert*n_v_invert;



for i=1:3
    
    h(i)=drawCuboid([obs_list(i,4:6) obs_list(i,1:3)]);
    set(h(i), 'linestyle', ':');
    set(h(i), 'facecolor', 'y');
    set(h(i), 'FaceAlpha', 0.7);
    
    
end
plot3(start_pos(1),start_pos(2),start_pos(3),'.','markersize',24,'color',[1 0 1]) % start marker
hold on
plot3(goal_pos(1),goal_pos(2),goal_pos(3),'.g','markersize',24,'color',[0 0.8 0]) % goal marker
hold on

curr_pos=start_pos;
flag=1;
p_all_idx=1;
idx=1;
while norm(curr_pos-goal_pos)>dg
    node_pos=cat(1,Tree.nodes.pos);
    [~,maxCost_idx]=max(cat(1,Tree.nodes.dis_cost));
    [~,mostFaiure_idx]=max(cat(1,Tree.nodes.faiureNum));
    if Tree.nodes(p_all_idx).faiureNum>0 || Tree.nodes(idx).faiureNum>0
        flag=0;
    else
        flag=1;
    end
    %rnd=getRandomPoint(goal_pos, 90,[0.5 0.3 0.2]);
    rnd=AdaptiveSample1(0.5,goal_pos,node_pos,Tree.nodes(maxCost_idx).pos,Tree.nodes(mostFaiure_idx).pos,pi/3,flag,R1);
    %rnd_handle = plot3(rnd(1), rnd(2),rnd(3), 'ko', 'MarkerSize', 4, 'MarkerFaceColor','r');
    %rnd=AdaptiveSample(o_efr,start_pos,goal_pos,Tree.nodes(maxCost_idx).pos,Tree.nodes(mostFaiure_idx).pos,node_pos,R1);
    dist_points = pdist2(node_pos,rnd,'squaredeuclidean');
    [sqDist,idx] = min(dist_points); %临时父节点的位置索引和距离
    %   Bring the node at a distance of epsilon near to the closest node
    nearest_point = node_pos(idx,:); % 最近点坐标
    n_dist = realsqrt(sqDist); %最近点距离
    new_point_u=(rnd - nearest_point)/n_dist; % 生长方向， 指向随机点
    new_point = Tree.nodes(idx).pos + step_size*new_point_u;
    [collision,BestDis]=checkDis(Tree.nodes(idx).pos ,new_point,obs_list);
    %Tree.nodes(idx).faiureNum=0;
    Tree.nodes(idx).extendNum=Tree.nodes(idx).extendNum+1; %拓展次数+1
    if collision || ~isInWorkspace(new_point,250,150,650) || BestDis< bg
        Tree.nodes(idx).faiureNum=Tree.nodes(idx).faiureNum+1;
        continue
    end
    
    all_edge_wt = pdist2(node_pos,new_point,'squaredeuclidean'); % 新节点到所有点的距离,这一步给新节点选一个父节点
    n_node_idx = all_edge_wt < ball_radius & all_edge_wt > 0 ; % 新节点邻居点索引
    n_nodes = find(n_node_idx); %邻居点的索引
    
    n_edge_wt = realsqrt(all_edge_wt(n_node_idx)); % 邻居点到距离
    n_total_cost = n_edge_wt+cat(1,Tree.nodes(n_node_idx).real_cost); %邻居点的全部代价
    [p_cost,p_idx] = min(n_total_cost); % 选取最小的代价 为父节点
    p_all_idx=n_nodes(p_idx); %父节点在树上的索引
    if isempty(n_nodes)
        p_all_idx=idx;
    end
    
    p_new_point_u=(new_point-Tree.nodes(p_all_idx).pos)/norm(new_point-Tree.nodes(p_all_idx).pos); %重新选择父节点之后的方向
    [collision,BestDis]=checkDis(Tree.nodes(p_all_idx).pos ,new_point,obs_list); %重新检查
    Tree.nodes(p_all_idx).extendNum=Tree.nodes(p_all_idx).extendNum+1;%拓展次数+1
    if collision || ~isInWorkspace(new_point,250,150,650) || BestDis< bg
        Tree.nodes(p_all_idx).faiureNum=Tree.nodes(p_all_idx).faiureNum+1;
        continue
    end
    
    count=count+1;
    
    Tree.nodes(count).pos=new_point;% 初始位置
    Tree.nodes(count).indPrev=p_all_idx; %父节点索引
    Tree.nodes(count).dis_cost=Tree.nodes(p_all_idx).dis_cost+step_size;
    Tree.nodes(count).real_cost=getConHullCost(new_point');
    Tree.nodes(count).BestDis=BestDis;
    Tree.nodes(count).faiureNum=0;
    Tree.nodes(count).extendNum=0.0001;
    Tree.nodes(count).o_efr=Tree.nodes(count).faiureNum/Tree.nodes(count).extendNum;
    
    
    l_handle = plot3([Tree.nodes(p_all_idx).pos(1), new_point(1)], [Tree.nodes(p_all_idx).pos(2), new_point(2)], [Tree.nodes(p_all_idx).pos(3), new_point(3)],'b', 'Linewidth', 2);
    p_handle = plot3(new_point(1), new_point(2),new_point(3), 'ko', 'MarkerSize', 4, 'MarkerFaceColor','k');
    %rnd_handle = plot3(rnd(1), rnd(2),rnd(3), 'ko', 'MarkerSize', 4, 'MarkerFaceColor','r');
    hold on
    curr_pos=new_point;
    
    pause(0.1)
    drawnow
    
end
phIndforward=backPathIdx(count,Tree);
phInd=pathSmooth(phIndforward,Tree,obs_list);
zlabel('{\it{z}}-axis[mm]')
ylabel('{\it{y}}-axis[mm]')
xlabel('{\it{x}}-axis[mm]')
set(gca,'YTick',-600:200:600)
set(gca,'XTick',-600:200:600)
set(gca,'FontSize',12);
set(gca,'Fontname','times new Roman')

 for i=1:length(phIndforward)-1
 plot3([Tree.nodes(phIndforward(i)).pos(1)  Tree.nodes(phIndforward(i+1)).pos(1)], [Tree.nodes(phIndforward(i)).pos(2)  Tree.nodes(phIndforward(i+1)).pos(2)],  [Tree.nodes(phIndforward(i)).pos(3)  Tree.nodes(phIndforward(i+1)).pos(3)],'g', 'Linewidth', 4);
 end
 
 for i=1:length(phInd)-1
 plot3([Tree.nodes(phInd(i)).pos(1)  Tree.nodes(phInd(i+1)).pos(1)], [Tree.nodes(phInd(i)).pos(2)  Tree.nodes(phInd(i+1)).pos(2)],  [Tree.nodes(phInd(i)).pos(3)  Tree.nodes(phInd(i+1)).pos(3)],'r', 'Linewidth', 4);
 end


function rand_pos=AdaptiveSample(o_efr,start_pos,goal_pos,maxCostNode_pos,mostFaiure_pos,TreeAllPos,R1) %
r1=rand(1);
if r1>o_efr
    s=(start_pos-goal_pos)/norm(start_pos-goal_pos);
    a=(maxCostNode_pos-goal_pos)/norm(maxCostNode_pos-goal_pos);
    sita=acos(dot(s,a));
    R=norm(maxCostNode_pos-goal_pos);
    
    R=R*power(rand(1),1/3);
    sita1=-sita+2*sita*rand(1);
    sita2=rand(1)*2*pi;
    
    z=R*cos(sita1);
    x=R*sin(sita1)*cos(sita2);
    y=R*sin(sita1)*sin(sita2);
    
    rand_pos=(R1*[x y z]')'+goal_pos;
else
    center_pos=mean(TreeAllPos);
    R=norm(center_pos-mostFaiure_pos)*power(rand(1),1/3);
    
    sita1=pi*rand(1);
    sita2=2*pi*rand(1);
    
    z=R*cos(sita1);
    x=R*sin(sita1)*cos(sita2);
    y=R*sin(sita1)*sin(sita2);
    
    rand_pos=[x y z];
end
end



function rand_pos=AdaptiveSample1(o_efr,goal_pos,TreeAllPos,maxCostNode_pos,mostFaiure_pos,sita,flag,R1) %
r1=rand(1);
if flag
    rand_pos=goal_pos;
else
    
    if r1>o_efr
        R=norm(maxCostNode_pos-goal_pos);
        R=R*power(rand(1),1/3);
        sita1=-sita+2*sita*rand(1);
        sita2=rand(1)*2*pi;
        
        z=R*cos(sita1);
        x=R*sin(sita1)*cos(sita2);
        y=R*sin(sita1)*sin(sita2);
        
        rand_pos=(R1*[x y z]')'+goal_pos;
    else
        center_pos=mean(TreeAllPos);
        %R=norm(center_pos-mostFaiure_pos)*power(rand(1),1/3);
        R=400*power(rand(1),1/3);
        sita1=acos(rand(1)*2-1);
        sita2=2*pi*rand(1);
        
        z=R*cos(sita1);
        x=R*sin(sita1)*cos(sita2);
        y=R*sin(sita1)*sin(sita2);
        
        rand_pos=[x y z]+center_pos;
    end
end
end




function real_cost=getConHullCost(G)
% G 列向量
max_cond=0.0079; min_cond=0.0016;

max_av=2.9587e+07;
min_av=2.6388e+07;
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
%C1=[];
%C2=[];%Normalized

%G=[x y z]';


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
[~,av2] = convhull(A_alphaT(:,1),A_alphaT(:,2),A_alphaT(:,3),'Simplify',true);
%C1=[C1;x y z av2];
hullCost=(av2-min_av)/(max_av-min_av);

nJ=J';
con1=cond(nJ);
con1=1/con1;

condCost=(con1-min_cond)/(max_cond-min_cond);
real_cost=hullCost+condCost;
end


function phIndforward=backPathIdx(leafNodes,Tree)
phInd=leafNodes;
phIndex = Tree.nodes(leafNodes).indPrev;
phInd=[phInd phIndex];
while 1
    
    phIndex = Tree.nodes(phIndex).indPrev;    % 沿终点回溯到起点
    if phIndex == 0
        break
    end
    
    phInd=[phInd phIndex];
       
end
 phIndforward=fliplr(phInd);
end
% 
%  for i=1:length(phIndforward)-1
%  plot3([Tree.nodes(phIndforward(i)).pos(1)  Tree.nodes(phIndforward(i+1)).pos(1)], [Tree.nodes(phIndforward(i)).pos(2)  Tree.nodes(phIndforward(i+1)).pos(2)],  [Tree.nodes(phIndforward(i)).pos(3)  Tree.nodes(phIndforward(i+1)).pos(3)],'g', 'Linewidth', 4);
%  end
%  
%  for i=1:length(phInd)-1
%  plot3([Tree.nodes(phInd(i)).pos(1)  Tree.nodes(phInd(i+1)).pos(1)], [Tree.nodes(phInd(i)).pos(2)  Tree.nodes(phInd(i+1)).pos(2)],  [Tree.nodes(phInd(i)).pos(3)  Tree.nodes(phInd(i+1)).pos(3)],'r', 'Linewidth', 4);
%  end

function phInd=pathSmooth(phIndforward,Tree,obs_list)
i=1;
phInd=phIndforward(i);
N=length(phIndforward);
while  i~=N
    j=N;
    while j~=i
        [collision,BestDis]=checkDis(Tree.nodes(phIndforward(i)).pos,Tree.nodes(phIndforward(j)).pos,obs_list);
        if ~collision
            i=j;
            phInd=[phInd phIndforward(i)];
            break
        end
        j=j-1;
        
    end
end


end
        

% 2obstacle view(-146.5,21.6)
