% Manuscript: Cognitive reflection and the coronavirus conspiracy beliefs

% @Hashem Sadeghiyeh

% August 02, 2020


%%
clear all; clc;
[A, title, ~] = xlsread ('/corona/data_conspiracy_crt.xlsx'); 
n = size(A, 1);
%%
label(1, 3) = {'China built'};
label(1, 4) = {'USA to attack China'};
label(1, 5) = {'USA to attack Iran'};
label(1, 6) = {'Russia built'};
label(1, 7) = {'secret lab accident'};
label(1, 8) = {'wild animals'};
label(1, 9) = {'fake news'};
label(1, 10) = {'divine punishment'};
label(1, 11) = {'nobody knows'};
label(1, 12) = {'man-made'};

%% Arizona color palette
AZred = [171,5,32]/256;
AZblue = [12,35,75]/256;
AZcactus = [92, 135, 39]/256;
AZsky = [132, 210, 226]/256;
AZriver = [7, 104, 115]/256;
AZsand = [241, 158, 31]/256;
AZmesa = [183, 85, 39]/256;
AZbrick = [74, 48, 39]/256;
%% intuitive responses
for i=1:n
    intuition(i,1) = (A(i,13) == 10 );
    intuition(i,2) = (A(i,14) == 100);
    intuition(i,3) = (A(i,15) == 24);
end
intuition = double(intuition)
intuition(:,4) = intuition(:,1) + intuition(:,2) + intuition(:,3)
l(1) = {'Intuition-1'}; l(2) = {'Intuition-2'}; 
l(3) = {'Intuition-3'}; l(4) = {'Intuition'}; 
%% reflective responses
for i=1:n
    reflection(i,1) = (A(i,13) == 5 );
    reflection(i,2) = (A(i,14) == 5);
    reflection(i,3) = (A(i,15) == 47);
end
reflection = double(reflection)
reflection(:,4) = reflection(:,1) + reflection(:,2) + reflection(:,3)
l(5) = {'Reflection-1'}; l(6) = {'Reflection-2'}; 
l(7) = {'Reflection-3'}; l(8) = {'Reflection'}; 

%% gender
males = sum(A(:,16)==1)
females = sum(A(:,16)==2)
%% age
age_mean = mean(A(:,17))
age_median = median(A(:,17))
age_min = min(A(:,17))
age_max = max(A(:,17))
%% language chosen, FA or EN
for i=1:n
    if title{i+1,2} == 'FA'
        farsi(i,1) = 1;
    else
        farsi(i,1) = 0;
    end
end
farsi_sum = sum(farsi==1)
english_sum = sum(farsi==0)

%% Figure 1 -- Descriptives
figure(1);
for i=16:19
    subplot(2,2,i-15)
    histogram(A(:,i),'Facecolor', AZsand)
    set(gca,'fontsize',15);
    xlabel(title{1,i}, 'FontSize', 20);
    if i == 16
        xticks([1 2]);
        xticklabels({'Male', 'Female'});
    end
    if i == 18
        xticks([1 2 3 4]);
        xticklabels({'Single', 'Married', 'Divorced', 'Widowed'});
    end
    if i == 19
        xticks([1 2 3 4 5 6]);
        xticklabels({'<H', 'H', '<2y', '2y', '4y', 'G'});
    end
end
%% Figure 2 --- Histograms Beliefs 
figure(2);
for i=3:12
    subplot(4,3,i-2)
    histogram(A(:,i), 5, 'Facecolor', AZsand)
    set(gca,'fontsize',10);
    xlabel(label{1,i}, 'FontSize', 15)
end
%% Figure 3 --- Histograms CRT 
figure(3);
subplot(1,2,1)
histogram(reflection(:,4), 'Facecolor', AZsand)
set(gca,'fontsize',15);
xlabel(l(8), 'FontSize', 20)

subplot(1,2,2)
histogram(intuition(:,4), 'Facecolor', AZsand)
set(gca,'fontsize',15);
xlabel(l(4), 'FontSize', 20)

%% Table 1
for i=1:10
    table1(i).trait = title{1,i+2};
    table1(i).Min = nanmin(A(:,i+2));
    table1(i).Max = nanmax(A(:,i+2));
    table1(i).Mean = nanmean(A(:,i+2));
    table1(i).SD = nanstd(A(:,i+2));
end
%% Table 2
intuition = double(intuition)
reflection = double(reflection)
for i=1:4
    table2(i).trait = l(i);
    table2(i).Min = nanmin(intuition(:,i));
    table2(i).Max = nanmax(intuition(:,i));
    table2(i).Mean = nanmean(intuition(:,i));
    table2(i).SD = nanstd(intuition(:,i));
end
for i=5:8
    table2(i).trait = l(i);
    table2(i).Min = nanmin(reflection(:,i-4));
    table2(i).Max = nanmax(reflection(:,i-4));
    table2(i).Mean = nanmean(reflection(:,i-4));
    table2(i).SD = nanstd(reflection(:,i-4));
end

%% Figure 4 - Percentage of answers 
for i=1:n
    blank(i,1) = isnan(A(i,13));
    blank(i,2) = isnan(A(i,14));
    blank(i,3) = isnan(A(i,15));
end
blank = double(blank);
blank(:,4) = blank(:,1)+blank(:,2)+blank(:,3);

other(:,1) = double(~intuition(:,1) & ~reflection(:,1) & ~blank(:,1));
other(:,2) = double(~intuition(:,2) & ~reflection(:,2) & ~blank(:,2));
other(:,3) = double(~intuition(:,3) & ~reflection(:,3) & ~blank(:,3));
other(:,4) = other(:,1)+other(:,2)+other(:,3);
 
ref1 = mean(reflection(:,1));
ref2 = mean(reflection(:,2));
ref3 = mean(reflection(:,3));
int1 = mean(intuition(:,1));
int2 = mean(intuition(:,2));
int3 = mean(intuition(:,3));
nan1 = mean(blank(:,1));
nan2 = mean(blank(:,2));
nan3 = mean(blank(:,3));
oth1 = mean(other(:,1));
oth2 = mean(other(:,2));
oth3 = mean(other(:,3));

figure(4);
y = 100 * [ref1, int1, oth1, nan1; ref2, int2, oth2, nan2; ref3, int3, oth3, nan3];
X = categorical({'1.Bat', '2.Widget', '3.Lake'});
h = bar(X, y, 'group');
box off;
a = (1:size(y,1)).';
x = [a-0.27 a-.09 a+.09 a+0.27];
for k=1:size(y,1)
    for m = 1:size(y,2)
        text(x(k,m),y(k,m),[num2str(y(k,m),'%0.1f') '%'],...
            'HorizontalAlignment','center',...
            'VerticalAlignment','bottom', 'fontsize',15)
    end
end
h(1).FaceColor = AZblue;
h(2).FaceColor = AZred;
h(3).FaceColor = AZmesa;
h(4).FaceColor = AZbrick;
legend show;
legend('Correct', 'Intuitive', 'Other', 'Blank', 'Box', 'off', 'Position', [.85 .84 .1 .05]);
set(gca, 'fontsize', 25);
% set(gca,'Tickdir','out')
set(gca,'TickLength',[0 0]);
% xticklabels({'Bat', 'Machine', 'Lake'});
xlabel('Cognitive Reflection Test items');
ylabel('Percentage of Answering');

%% Table 3: Correlation Matrix (10 statements)
[table3, p_table3] = corrcoef(A(:,3:12))

%% Figure 5: correlations between CRT and Conspiracy/Founder reflection
conspiracy = sum([A(:,3:6) A(:,9) A(:,12)],2)/6;
conspiracy_max = max([A(:,3:6) A(:,9) A(:,12)],[],2);
figure(5);
subplot(2,2,1)
b = boxplot(conspiracy_max, reflection(:,4), 'Notch', 'on', 'Widths', .3, 'Colors', AZsky); hold on
set(b, 'LineWidth',3);
set(gca,'FontSize',20)
xlabel('Cognitive Reflection');
ylabel('Conspiracy Beliefs');
title('Conspiracy Beliefs by CRT scores');
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', AZsand);
[r, p] = partialcorr(reflection(:,4), conspiracy_max, A(:,16:19), 'Type','Spearman', 'rows', 'complete');

text(1.05,10,strcat('\rho = ', {' '}, num2str(round(r*100)/100),'; p = ', {' '}, num2str(round(p*100000)/100000)),'FontWeight','Normal', 'FontSize',15);
p = polyfit(reflection(:,4), conspiracy_max,1);
f = polyval(p, [0 1 2 3]);
plot([1 2 3 4], f, '--', 'color', AZblue, 'LineWidth',2); 

subplot(2,2,2)
b = boxplot(A(:,8), reflection(:,4), 'Notch', 'on', 'Widths', .3, 'Colors', AZsky); hold on
set(b, 'LineWidth',3);
set(gca,'FontSize',20)
xlabel('Cognitive Reflection');
ylabel('Founded Belief');
title('Conspiracy Beliefs by CRT scores');
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', AZsand);
[r, p] = partialcorr(reflection(:,4), A(:,8), A(:,16:19), 'Type','Spearman', 'rows', 'complete');
text(1.05,95,strcat('\rho = ', {' '}, num2str(round(r*100)/100),'; p = ', {' '}, num2str(round(p*1000000)/1000000)),'FontWeight','Normal', 'FontSize',15);
p = polyfit(reflection(:,4), A(:,8),1);
f = polyval(p, [0 1 2 3]);
plot([1 2 3 4], f, '--', 'color', AZblue, 'LineWidth',2);

subplot(2,2,3)
b = boxplot(conspiracy_max, intuition(:,4), 'Notch', 'on', 'Widths', .3, 'Colors', AZsky); hold on
set(b, 'LineWidth',3);
set(gca,'FontSize',20)
xlabel('Intuitive Responses');
ylabel('Conspiracy Beliefs');
title('Conspiracy Beliefs by CRT scores');
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', AZsand);
[r, p] = partialcorr(intuition(:,4), conspiracy_max, [farsi A(:,16:19)], 'Type','Spearman', 'rows', 'complete');
text(1.5,25,strcat('\rho = ', {' '}, num2str(round(r*100)/100),'; p = ', {' '}, num2str(round(p*10000)/10000)),'FontWeight','Normal', 'FontSize',15);
p = polyfit(intuition(:,4), conspiracy_max,1);
f = polyval(p, [0 1 2 3]);
plot([1 2 3 4], f, '--', 'color', AZblue, 'LineWidth',2); 

subplot(2,2,4)
b = boxplot(A(:,8), intuition(:,4), 'Notch', 'on', 'Widths', .3, 'Colors', AZsky); hold on
set(b, 'LineWidth',3);
set(gca,'FontSize',20)
xlabel('Intuitive Responses');
ylabel('Founded Belief');
title('Conspiracy Beliefs by CRT scores');
lines = findobj(gcf, 'type', 'line', 'Tag', 'Median');
set(lines, 'Color', AZsand);
[r, p] = partialcorr(intuition(:,4), A(:,8), [farsi A(:,16:19)], 'Type','Spearman', 'rows', 'complete');
text(1.5,95,strcat('\rho = ', {' '}, num2str(round(r*100)/100),'; p = ', {' '}, num2str(round(p*10000)/10000)),'FontWeight','Normal', 'FontSize',15);
p = polyfit(intuition(:,4), A(:,8),1);
f = polyval(p, [0 1 2 3]);
plot([1 2 3 4], f, '--', 'color', AZblue, 'LineWidth',2);

%% Table 4 -- correlations between reflection/intuition and all 10 beliefs 
for i=1:10
    [r, p] = partialcorr(reflection(:,4), A(:,i+2), A(:,16:19), 'Type','Spearman', 'rows', 'complete');
    [r2, p2] = partialcorr(intuition(:,4), A(:,i+2), A(:,16:19), 'Type','Spearman', 'rows', 'complete');
    
    table4(i).belief = label{1, i+2};
    table4(i).r = r;
    table4(i).p = p;
    table4(i).r2 = r2;
    table4(i).p2 = p2;
end