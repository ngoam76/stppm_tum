%Read data to variable v
v=load('Property_Rents.csv');
n=size(v,1);  %extract number of datasets

%Prepare results
dist=zeros(1,n);

%Pass1
%Create bins according standard 1-3  
mean1=0;
mean2=0;
mean3=0;

var1=0;
var2=0;
var3=0;

%Create Counters for bins according standard 1-3  
i1=0;
i2=0;
i3=0;

%Compute means per bin
for i=1:n
    if (v(i,4)==1) mean1=mean1+v(i,2)/v(i,3);  i1=i1+1;  end
    if (v(i,4)==2) mean2=mean2+v(i,2)/v(i,3);  i2=i2+1;  end
    if (v(i,4)==3) mean3=mean3+v(i,2)/v(i,3);  i3=i3+1;  end
end;
mean1=mean1/i1;
mean2=mean2/i2;
mean3=mean3/i3;


%Pass2
%Compute variance per bin
for i=1:n
    if (v(i,4)==1) var1=var1+(v(i,2)/v(i,3)-mean1)^2;  end
    if (v(i,4)==2) var2=var2+(v(i,2)/v(i,3)-mean2)^2;   end
    if (v(i,4)==3) var3=var3+(v(i,2)/v(i,3)-mean3)^2;   end
end;
var1=var1/(i1-1);
var2=var2/(i2-1);
var3=var3/(i3-1);

%Pass3
%Compute distance per bin
for i=1:n
    if (v(i,4)==1) dist(i)=(v(i,2)/v(i,3)-mean1)^2/var1;  end
    if (v(i,4)==2) dist(i)=(v(i,2)/v(i,3)-mean2)^2/var2;  end
    if (v(i,4)==3) dist(i)=(v(i,2)/v(i,3)-mean3)^2/var3;  end
end;


writematrix(dist,'Property_Rents_Bandwidth.csv');

%Pass4
%Display
disp1=zeros(1,n); %
disp2=zeros(1,n); %
disp3=zeros(1,n); %
rdisp1=zeros(1,n); %
rdisp2=zeros(1,n); %
rdisp3=zeros(1,n); %
indx=zeros(1,n);

for i=1:n
    disp1(i)=inf;
    disp2(i)=inf;
    disp3(i)=inf;
    
    rdisp1(i)=inf;
    rdisp2(i)=inf;
    rdisp3(i)=inf;
    
    if (v(i,4)==1) disp1(i)=v(i,2)/v(i,3); rdisp1(i)=dist(i);end
    if (v(i,4)==2) disp2(i)=v(i,2)/v(i,3); rdisp2(i)=dist(i);end
    if (v(i,4)==3) disp3(i)=v(i,2)/v(i,3); rdisp3(i)=dist(i);end
    indx(i)=i;
end;

figure;
tiledlayout(2,1);
tile1=nexttile;
plot(tile1,indx,disp1,'+r');
axis([0,n,0,40]);
hold on;
grid on;
yline(mean1);
yline(mean1+sqrt(var1));
yline(mean1-sqrt(var1));
tile2=nexttile;
plot(tile2,indx,rdisp1,'.b');
axis([0,n,0,5]);
grid on;


figure;
tiledlayout(2,1);
tile1=nexttile;
plot(tile1,indx,disp2,'+r');
axis([0,n,0,40]);
hold on;
grid on;
yline(mean2);
yline(mean2+sqrt(var2));
yline(mean2-sqrt(var2));
tile2=nexttile;
plot(tile2,indx,rdisp2,'.b');
axis([0,n,0,5]);
grid on;


figure;
tiledlayout(2,1);
tile1=nexttile;
plot(tile1,indx,disp3,'+r');
axis([0,n,0,40]);
hold on;
grid on;
yline(mean3);
yline(mean3+sqrt(var3));
yline(mean3-sqrt(var3));
tile2=nexttile;
plot(tile2,indx,rdisp3,'.b');
axis([0,n,0,5]);
grid on;
