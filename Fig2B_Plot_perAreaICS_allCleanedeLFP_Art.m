%% Fig2B_Plot_perAreasICS_allCleanedLFP_Art
% creates figure 2B eLFP ICMS
% this mfiles plots the mean zscore for each receiver area when sender area
% was stimulated
% updated yvz April 30th, 2025


clear all;
close all;

s_z1=  [];
s_z2=  [];
s_z3=  [];
s_z4 = [];
s_z5 = [];
s_z6 = [];
s_z7 = [];
s_z8 = [];

PrintOn=0; % set to 1 to print the figure. 

days ={'210914', '210917', '210923'} % recording dates 


% This path needs to be changed accordingly to where you have the data
% stored. 
TargetDir='/Users/yuriria/Dropbox/FreiwaldLabMine/code/A_GitHub/Figure2/v1/data/Cleaned_eLFP'; % DB path
%TargetDir='/Users/yuriria/Documents/MATLAB/Fx_Con_Analysis/LFP_related/Cleaned_eLFP/';local
%machine. 

areas = {'S1', 'M1m',  'PMVm',  'M3'};

a=4; % set depending on the area to be the current Sender (a=1 (S1), a=2(M1m), a=3 (PMVm), a=4 (M3)

for d=1:length(days)
    cd([TargetDir,'/',days{d}])
    cd(areas{a});
    fname=['Barney_', days{d},'_', areas{a},'_Amp250.mat'];
    load(fname);

    if strcmp(areas{a},'S1')
        s_z1=  [s_z1; z2]; % M1m
        s_z4 = [s_z4; z5]; % pMVm
        s_z6 = [s_z6; z7]; % M3
        labelAreasS={'M1m','M1l', 'F4','PMVm', 'PMVl','M3','',''};
        labelAreas={'M3','M1m', 'PMVm'}; % for figure purposes

    elseif strcmp(areas{a},'M1m')
        if strcmp(days{d},'210923')
            z6=[];
        end
        s_z1=  [s_z1; z1]; % S1
        s_z4 = [s_z4; z5]; % PMVm
        s_z6 = [s_z6; z7]; % M3
        labelAreasS={'S1','M1l', 'F4','PMVm', 'PMVl','M3','',''};
        labelAreas={'S1','PMVm','M3'};

    elseif strcmp(areas{a}, 'PMVm')
        s_z1=  [s_z1; z1]; % S1
        s_z2=  [s_z2; z2]; % M1m
        s_z6 = [s_z6; z7]; % M3
        labelAreasS={'S1','M1m', 'M1l','F4', 'PMVl','M3','',''};
        labelAreas={'S1','M1m','M3'};

    elseif strcmp(areas{a}, 'M3')
        s_z1=  [s_z1; z1]; % S1 %
        s_z2=  [s_z2; z2]; % M1m
        s_z3 = [s_z3; z3]; % M1l
        s_z4 = [s_z4; z4]; % F4
        s_z5 = [s_z5; z5]; % PMVm
        labelAreasS={'S1','M1m', 'M1l', 'F4', 'PMVm','','',''};
        labelAreas={'S1','M1m', 'PMVm'};

    end
end
%end

% Colors of the Arrays in Barney !  
c1=[0.7176    0.2745    1.0000]; % S1
c2= [ 0.8510    0.3255    0.0980]; % M1
c3= [ 0.6353    0.0784    0.1843];
c4 = [1 0 1];
c5 = [0 0 1]; % PMVm
c6 = [0.9294    0.6941    0.1255];
c7 = [ 1.0000    0.0745    0.6510]; % M3 

%% ICS in 
figure(a); clf; hold on;

if strcmp(areas{a},'S1')==1 
    time=1: size(s_z1,2);
  
    % all togethe the mean
    plot(time, mean(s_z6),'Color', c7,'LineWidth', 3);
    plot(time, mean(s_z1),'Color', c2,'LineWidth', 3);
    plot(time, mean(s_z4),'Color', c5,'LineWidth', 3);
    legend('M3', 'M1', 'PMVm', 'Box','off', 'Color', 'none')

elseif strcmp(areas{a},'M1m')==1
    time=1: size(s_z1,2);
  
    % all together the mean
    plot(time, mean(s_z1,1),'-','LineWidth', 3,'Color', c1); % S1
    plot(time, mean(s_z4,1),'-','LineWidth', 3,'Color', c5); % PMVm
    plot(time, mean(s_z6,1),'-','LineWidth', 3,'Color', c7); % M3
   legend('S1', 'PMVm', 'M3', 'Box','off', 'Color', 'none')
   

elseif strcmp(areas{a},'PMVm')==1 
    time=1: size(s_z1,2);

    % all together mean
    plot(time, mean(s_z1,1),'-','LineWidth', 3,'Color', c1);
    plot(time, mean(s_z2,1),'-','LineWidth', 3,'Color', c2);
    plot(time, mean(s_z6,1),'-','LineWidth', 3,'Color', c7);
    legend('S1', 'M1m', 'M3', 'Box','off', 'Color', 'none')

elseif strcmp(areas{a},'M3')==1 
   time=1: size(s_z1,2);
 
   plot(time, mean(s_z1,1),'-','LineWidth', 3,'Color', c1); % S1
   plot(time, mean(s_z2,1),'-','LineWidth', 3,'Color', c2); % M1m
   plot(time, mean(s_z5,1),'-','LineWidth', 3,'Color', c5); % PMV 
   legend('S1', 'M1m', 'PMVm', 'Box','off', 'Color', 'none')
  
end

gcf;
hold on;
yline(0); xline(100)
%title(['Barney ICS in ', areas{a}, '  nDays=', num2str(length(days))],'fontsize', 12);
xticks([1:50:350]);  xu =-100:50:250;
set(gca,'XTickLabel', string(xu),'fontsize', 16)
gca; ax=axis; ylim([ax(3) ax(4)]);
xlabel('time (ms)','fontsize', 16); ylabel('mean eLFP (zscore)','fontsize', 16)
legend(labelAreas, 'fontsize', 12,'Box','off', 'Color', 'none');
ylim([-20 20])

storename=['Barney_eLFP_', areas{a}, 'bidirectM3_nDays', num2str(length(days))]

if PrintOn==1
    StoreDir='/Users/yuriria/Documents/MATLAB/Fx_Con_Analysis/LFP_related/Cleaned_eLFP/test_241127'
    cd(StoreDir)
    savefig(gcf,storename)
    % print with high resolution (e.g., 300 dpi)
     print('-dpng', '-r300', storename)
     set(gcf, 'Position', get(0, 'Screensize'));
     print('-dpng', '-r300', storename)
end
