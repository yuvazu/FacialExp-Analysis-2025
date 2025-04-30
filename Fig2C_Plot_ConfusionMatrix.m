%% Figure2C_Plot_ConfusionMatrix
% This mfile plots the confusion matrix of figure 2C 
% updated yvz April 30th, 2025 


clear all
close all


% Update this path, for the path were the data are located
TargetDir='/Users/yuriria/Documents/MATLAB/Fx_Con_Analysis/LFP_related/Cleaned_eLFP/test_241127/Clean_dPT_AUC_Range3to70ms' % local machine
%TargetDir='/Users/yuriria/Dropbox/FreiwaldLabMine/code/A_GitHub/Figure2/v1/data/Clean_dPT_AUC_Range3to70ms';DB
cd(TargetDir)

printOn=0;

% load variables
m=nan(4,4);
areas = {'S1', 'M1m', 'PMVm', 'M3' };

load('S1Clean_dPT_AUC.mat');
store_dPT
m(2:end,1)= store_dPT;

load('M1mClean_dPT_AUC.mat')
store_dPT
m(1,2)= store_dPT(1);
m(3:4,2)= store_dPT(2:end);


load('PMVmClean_dPT_AUC.mat')
store_dPT
m(1:2,3)= store_dPT(1:2);
m(4,3)= store_dPT(end);

load('M3Clean_dPT_AUC.mat')
store_dPT
m(1:3,4)= store_dPT;


% plot the matrix
figure(100);
imagesc(m)
cmap = parula(256);
hold on

[row,col] = find(isnan(m));
for i = 1:length(row)
    rectangle('Position',[col(i)-0.5,row(i)-0.5,1,1],'FaceColor',[0.5 0.5 0.5],'EdgeColor','none');
end

colorbar
xticks(1:length(areas)+1); set(gca, 'XtickLabels', areas)
yticks(1:length(areas)+1); set(gca, 'YtickLabels', areas)
a=colorbar; a.Label.String=['\delta', '|Pk-Tr|', '  (au)']; a.FontSize=14;
xlabel('Sender of ICS','FontSize',14);
ylabel('Receiver Area','FontSize',14);
set(gca,'FontSize',14)

if PrintOn==1
    title (['3-70 ms ', '\delta', '|Pk-Tr|', '  (au)'] )
    savefig('ConfusionMatrix_dPK-Tr_3to70ms')

    set(gcf, 'Position', get(0, 'Screensize'));
    print(gcf,'-dpng','ConfusionMatrix_dPK-Tr_3to70ms')
end

