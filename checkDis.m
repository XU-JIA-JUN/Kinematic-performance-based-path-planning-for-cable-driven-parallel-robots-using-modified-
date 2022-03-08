function [collision,BestDis]=checkDis(curr_pos,next_pos,obs_list)
E=130;
BestDis=10000;
[r,~]=size(obs_list);
for i=1:r
    
    [Dis,~]=GetSweptDistance(curr_pos,next_pos,obs_list(i,4:6),E,obs_list(i,1),obs_list(i,2),obs_list(i,3));
    if min(Dis)<BestDis
        BestDis=min(Dis);
    end
end

if BestDis<0.1
    collision=1;
else
    collision=0;
end
end