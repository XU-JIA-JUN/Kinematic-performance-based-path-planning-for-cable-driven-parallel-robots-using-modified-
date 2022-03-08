
for i=1:length(phIndforward) %%%%%%%%%%%未优化的视频
filename = 'MITE';
[cab1, cab2, cab3, cab4, cab5, cab6, cab7, cab8, cube] = eplot(Tree.nodes(phIndforward(i)).pos);
view(-274,18)
full_name = strcat(filename,num2str(i),'.jpg');
saveas(gcf,full_name);
        delete(cab1)
        delete(cab2)
        delete(cab3)
        delete(cab4)
        delete(cab5)
        delete(cab6)
        delete(cab7)
        delete(cab8)
        delete(cube)
end

C=[];
for i=1:length(phInd)-1
%     filename = 'MITE';
    step_size=10; %5mm步长
    L_two_points=norm(Tree.nodes(phInd(i)).pos-Tree.nodes(phInd(i+1)).pos); %两点长度
    V_two_points=(Tree.nodes(phInd(i+1)).pos-Tree.nodes(phInd(i)).pos)/L_two_points;
    N_two_points=floor(L_two_points/step_size)
    
    for j=0:N_two_points
        path_point=Tree.nodes(phInd(i)).pos+j*step_size*V_two_points
        C=[C;path_point];
    end
end
%%%%%%%%%%%%没有树的话
C=[];
for i=1:length(Q)-1
%     filename = 'MITE';
    step_size=10; %5mm步长
    L_two_points=norm(Q(i,:)-Q(i+1,:)); %两点长度
    V_two_points=(Q(i+1,:)-Q(i,:))/L_two_points;
    N_two_points=floor(L_two_points/step_size)
    
    for j=0:N_two_points
        path_point=Q(i,:)+j*step_size*V_two_points
        C=[C;path_point];
    end
end



        
for i=1:length(C) %%%%%%%%%%%未优化的视频
filename = 'MITE';
[cab1, cab2, cab3, cab4, cab5, cab6, cab7, cab8, cube] = eplot(C(i,:));
view(-274,18)
full_name = strcat(filename,num2str(i),'.jpg');
saveas(gcf,full_name);
        delete(cab1)
        delete(cab2)
        delete(cab3)
        delete(cab4)
        delete(cab5)
        delete(cab6)
        delete(cab7)
        delete(cab8)
        delete(cube)
end    
    
video_name='MITES2';
video_object = VideoWriter(video_name,'Uncompressed AVI');
%video_object.Quality = 100;
video_object.FrameRate = 4;
open(video_object);

for i = 1:length(C)
    frameName = strcat(filename,num2str(i),'.jpg')
    read_frame= im2frame(imread(frameName));
    writeVideo(video_object, read_frame);   
end
close(video_object);
    






video_name='MITES2';
video_object = VideoWriter(video_name,'Uncompressed AVI');
%video_object.Quality = 100;
video_object.FrameRate = 4;
open(video_object);

for i = 1:length(phIndforward)
    frameName = strcat(filename,num2str(i),'.jpg')
    read_frame= im2frame(imread(frameName));
    writeVideo(video_object, read_frame);   
end
close(video_object);

