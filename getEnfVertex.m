function ET=getEnfVertex(enf_point,E)

% enf_point : 末端执行器坐标
% E：末端执行器变长

E1=[enf_point(1)-E/2 enf_point(2)-E/2 enf_point(3)+E/2];
E2=[enf_point(1)-E/2 enf_point(2)+E/2 enf_point(3)+E/2];
E3=[enf_point(1)+E/2 enf_point(2)-E/2 enf_point(3)+E/2];
E4=[enf_point(1)+E/2 enf_point(2)+E/2 enf_point(3)+E/2];
E5=[enf_point(1)-E/2 enf_point(2)-E/2 enf_point(3)-E/2];
E6=[enf_point(1)-E/2 enf_point(2)+E/2 enf_point(3)-E/2];
E7=[enf_point(1)+E/2 enf_point(2)-E/2 enf_point(3)-E/2];
E8=[enf_point(1)+E/2 enf_point(2)+E/2 enf_point(3)-E/2];

ET=[E1;E2;E3;E4;E5;E6;E7;E8];
end