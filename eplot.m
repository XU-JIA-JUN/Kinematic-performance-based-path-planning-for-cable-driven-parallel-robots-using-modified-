function [cab1,cab2,cab3,cab4,cab5,cab6,cab7,cab8,cube]=eplot(endps)

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

          x1=0;
          x2=0;
          x3=0;

          RA=[cos(x3)*cos(x2),-sin(x3)*cos(x1)+cos(x3)*sin(x2)*sin(x1),sin(x3)*sin(x1)+cos(x3)*sin(x2)*cos(x1);
          cos(x2)*sin(x3),cos(x1)*cos(x3)+sin(x1)*sin(x2)*sin(x3),-cos(x3)*sin(x1)+cos(x1)*sin(x2)*sin(x3);-sin(x2),cos(x2)*sin(x1),cos(x1)*cos(x2)];
      h = gca;
axis([-600 600 -600 600 0 1000])
set(gca,'nextplot','replacechildren','box','off','color','w','xgrid','off')
hold on;
kx=[P7(1) P8(1) P4(1) P3(1) P7(1) P3(1) P1(1) P5(1) P7(1) P5(1) P1(1) P2(1) P6(1) P8(1) P4(1) P2(1) P6(1) P6(1) P5(1)];
ky=[P7(2) P8(2) P4(2) P3(2) P7(2) P3(2) P1(2) P5(2) P7(2) P5(2) P1(2) P2(2) P6(2) P8(2) P4(2) P2(2) P6(2) P6(2) P5(2)];
kz=[P7(3) P8(3) P4(3) P3(3) P7(3) P3(3) P1(3) P5(3) P7(3) P5(3) P1(3) P2(3) P6(3) P8(3) P4(3) P2(3) P6(3) P6(3) P5(3)];
plot3(kx,ky,kz,'r','linewidth',2);

text(P1(1),P1(2),P1(3),'A1')
text(P2(1),P2(2),P2(3),'A2')
text(P3(1),P3(2),P3(3),'A3')
text(P4(1),P4(2),P4(3),'A4')
text(P5(1),P5(2),P5(3),'A5')
text(P6(1),P6(2),P6(3),'A6')
text(P7(1),P7(2),P7(3),'A7')
text(P8(1),P8(2),P8(3),'A8')
         LL1=(RA*e1+endps')';
    LL2=(RA*e2+endps')';
    LL3=(RA*e3+endps')';
    LL4=(RA*e4+endps')';
    LL5=(RA*e5+endps')';
    LL6=(RA*e6+endps')';
    LL7=(RA*e7+endps')';
    LL8=(RA*e8+endps')';

cab1=line([LL1(1) P1(1)],[LL1(2) P1(2)],[LL1(3) P1(3)],'Color','k');
hold on
cab2=line([LL2(1) P2(1)],[LL2(2) P2(2)],[LL2(3) P2(3)],'Color','k');
cab3=line([LL3(1) P3(1)],[LL3(2) P3(2)],[LL3(3) P3(3)],'Color','k');
cab4=line([LL4(1) P4(1)],[LL4(2) P4(2)],[LL4(3) P4(3)],'Color','k');
cab5=line([LL5(1) P5(1)],[LL5(2) P5(2)],[LL5(3) P5(3)],'Color','k');
cab6=line([LL6(1) P6(1)],[LL6(2) P6(2)],[LL6(3) P6(3)],'Color','k');
cab7=line([LL7(1) P7(1)],[LL7(2) P7(2)],[LL7(3) P7(3)],'Color','k');
cab8=line([LL8(1) P8(1)],[LL8(2) P8(2)],[LL8(3) P8(3)],'Color','k');

x=[LL7(1) LL8(1) LL4(1) LL3(1) LL7(1) LL3(1) LL1(1) LL5(1) LL7(1) LL5(1) LL1(1) LL2(1) LL6(1) LL8(1) LL4(1) LL2(1) LL6(1) LL6(1) LL5(1)];
y=[LL7(2) LL8(2) LL4(2) LL3(2) LL7(2) LL3(2) LL1(2) LL5(2) LL7(2) LL5(2) LL1(2) LL2(2) LL6(2) LL8(2) LL4(2) LL2(2) LL6(2) LL6(2) LL5(2)];
z=[LL7(3) LL8(3) LL4(3) LL3(3) LL7(3) LL3(3) LL1(3) LL5(3) LL7(3) LL5(3) LL1(3) LL2(3) LL6(3) LL8(3) LL4(3) LL2(3) LL6(3) LL6(3) LL5(3)];
cube=plot3(x,y,z,'r','linewidth',1);
xlabel('x-axis[mm]')
ylabel('y-axis[mm]')
zlabel('z-axis[mm]')

end