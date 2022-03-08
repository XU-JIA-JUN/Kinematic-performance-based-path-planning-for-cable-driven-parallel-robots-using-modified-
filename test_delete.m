%测试然后删除

C=[];
for i=1:length(phInd)-1
%     filename = 'MITE';
    step_size=5; %5mm步长
    L_two_points=norm(Tree.nodes(phInd(i)).pos-Tree.nodes(phInd(i+1)).pos); %两点长度
    V_two_points=(Tree.nodes(phInd(i+1)).pos-Tree.nodes(phInd(i)).pos)/L_two_points;
    N_two_points=floor(L_two_points/step_size)
    
    for j=0:N_two_points
        path_point=Tree.nodes(phInd(i)).pos+j*step_size*V_two_points
        C=[C;path_point];
    end
end