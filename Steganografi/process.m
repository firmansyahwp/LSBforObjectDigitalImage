[B,L] = bwboundaries(bw,'noholes');
%labeling object
[~,N] = bwlabel(bw,8);
prop = regionprops(L, 'all');
for n=1:N
    boundary = B{n};
    text(boundary(1,2),boundary(1,1)-7,strcat(['n = ',num2str(n)]),'Color','r',...
        'FontSize',8,'FontWeight','bold');
    rectangle('Position', prop(n).BoundingBox, 'EdgeColor', 'g', 'LineWidth', 2);
end 