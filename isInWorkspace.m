function yes=isInWorkspace(NewNode,xylim,zlim,Zlim)

if (NewNode(1)>-xylim && NewNode(1)<xylim && NewNode(2)>-xylim && NewNode(2)<xylim && NewNode(3)<Zlim && NewNode(3)>zlim)
    
    yes=1;
    
else
    
    yes=0;
    
end