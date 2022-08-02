avg_d = 0;
n=0;
for i=1:length(layers)
    if ~layers(i).is_bifurcated
        c1=layers(i).inner_pts;
        c2=layers(i).inner_pts(wrapN([2:size(layers(i).inner_pts,1)+1],size(layers(i).inner_pts,1)),:);
        cir = sqrt(sum((c1-c2).^2,2));
        avg_d = avg_d+cir/pi;
        n=n+1;
    end
end
avg_d=sum(avg_d)/n