function [rho p] = fcnCorrMatrixPlot_Modified(A, B, VarName, caption)
% This function produces a correlation matrix scatterplot with
% least-squared fitted lines.
% Input A is a mxn matrix (m: # of observations, n: # of variables).
% VarName is a cell array with variable names correspond to columns of A.
% Values displayed in each subplot are correlation coefficient [p-value].
% Output: Correlation coefficients (rho) and the associated p-values (p).
% Change values of gap, marg_x, & marg_y to adjust spacing of subplots.
% In the main program, use orient tall/landscape & saveas to save the plot.
% Example:
% figTitle = 'An example of correlation matrix scatterplots';
% Var ={'Age' 'Height' 'GaitSpd' 'StrLgn' 'Cadence'};
% data = [58 76 136 164 100; 24 63 129 126 123; 29 70 118 146 97;...
% 21 69 101 123 99; 49 69 135 153 106; 47 70 126 148 101;...
% 58 69 132 146 108; 31 72 125 146 103];
% fcnCorrMatrixPlot(data, Var, figTitle);
% FigFile = 'SamplePlots'; orient tall
% saveas(gcf, FigFile,'jpg')

% John W. Chow, jchow@mmrcrehab.org, September 16, 2015
% Methodist Rehabilitation Center, Jackson, Mississippi, USA
% Created using R2015a

scrsz = get(0,'ScreenSize');
[m,n] = size(A);   % # of rows and columns of the input matrix

if n ~= length(VarName)
 disp('Warning: # of variables & # of columns not matched.'), pause
end

% Define a figure window position and size (full screen)
figure('Position',[.05*scrsz(3) .05*scrsz(4) .9*scrsz(3) .87*scrsz(4)]);

% Adjust marker and font sizes according to the # of columns
if n < 14
 gap_ht = .0195-.0015*n;          % Gap height between adjacent subplots
 gap_wd = .0195-.0015*n;          % Gap width between adjacent subplots
 symbolsize = 8.909-.4545*n;      % Marker size
 labelsize = 12.909-.5*n;         % Font size for text and ticklabel
else     % when # of variables >= 14
 gap_ht = 0; gap_wd = 0;
 symbolsize = 3;
 labelsize = 6;
end

%% Create subplot axes %%
% Modification of the function 'tight_subplot' by Pekka Kumpulainen
% www.mathworks.com/matlabcentral/fileexchange/27991-tight-subplot

gap = [gap_ht gap_wd];  % Gap height and width between adjacent subplots
marg_x = [.1 .05];      % Left and right margins of the figure
marg_y = [.1 .05];      % Bottom and top margins of the figure

% Determine the axis lengths of each subplot %
yAxLg = (1-sum(marg_y)-(n-2)*gap(1))/(n-1);
xAxLg = (1-sum(marg_x)-(n-2)*gap(2))/(n-1);

px = marg_x(1);    % x-origin of subplots in the 1st column

ha = zeros((n-2)*(n-2),1);   % Define an array of handles

counter = 0;

for i = 1:n-1      % # of columns of subplots = (n-1)
 
 py = 1-marg_y(2)-yAxLg;     % y-origin of the subplot in the 1st row
 
 if i > counter
  for j = 2:n      % # of rows of subplots
   if j > counter + 1
    pos = (i-1)+(j-2)*(n-1)+1;    % Subplot position (ID)
    ha(pos) = axes('Units','normalized','Position',[px py xAxLg yAxLg],...
     'XTickLabel','','YTickLabel','');
   end
   py = py-yAxLg-gap(1);     % y-origin of the next subplot in the same column
   if j == n
    counter = counter + 1;
    px = px+xAxLg+gap(2);    % x-origin of subplots in the next column
   end
  end    % j-loop for rows of subplot
  
 end     % if i > counter
 
end      % i-loop for columns of subplot
% End creating subplot axes

var = VarName;

[rho.A,p.A] = corr(A);  % correlation coefficient & associated p-values
[rho.B,p.B] = corr(B);

%% Create scatterplots with fitted lines from top to bottom %%
counter = 0;
for i = 1:n-1      % Loop for rows
 if i > counter
  for j = 2:n      % Loop for columns
   if j > counter+1
    X1 = A(:,i); Y1 = A(:,j);       % Data to be plotted
    X2 = B(:,i); Y2 = B(:,j);
    loc = (i-1)+(j-2)*(n-1)+1;    % Subplot location
    axes(ha(loc));
    plot(X1,Y1,'bo','MarkerSize',symbolsize,'MarkerFaceColor','b','MarkerEdgeColor','k')   % Marker shape: circle
    hold on
    plot(X2,Y2,'co','MarkerSize',symbolsize,'MarkerFaceColor','c','MarkerEdgeColor','k')
   
    
%     % Plot a least-squared fitted line %
%     P1 = polyfit(X1,Y1,1);      % 1st order polynomial (linear)
%     Yfit1 = P1(1)*X1+P1(2);      % y-values of the fitted line
%     P2 = polyfit(X2,Y2,1);      
%     Yfit2 = P2(1)*X2+P2(2);      
%                                 % Allow superimposed plots
%     plot(X1,Yfit1,'b-');       % Fitted line (color: red, type: solid)
%     plot(X2,Yfit2,'r-');
%     
    
    % Define the ranges for the x- and y-axis %
%     axis([min([X2])-.1*range([X2]) max([X2])+.1*range([X2]) min([Y2])-.1*range([Y2])...
%      max([Y2])+.25*range([Y2])]);
    axis([0 20 0 20])
    
    xLimit = get(gca, 'xlim');
    xLoc = xLimit(1) + .05*range(xLimit);   % x location for text
    yLimit = get(gca, 'ylim');
    yLoc = yLimit(1) + .925*range(yLimit);   % y location for text
    
%     % Add corr coef and p-value to each plot %
%     text(xLoc,yLoc,[num2str(rho.A(i,j),'%.3f')...
%      '[' num2str(p.A(i,j),'%.3f') ']'],'FontSize',labelsize);
    
    % Add ylabels to the subplots in the first column %
    if i == 1      
     ylabel(VarName{j},'FontSize',labelsize+2);
     ax = gca;
     ax.FontSize = labelsize+2;     % Ticklabel size
    else
     set(gca, 'YTickLabel','');
    end
    
    % Add xlabels to the subplots in the last row %
    if j == n      
     xlabel(VarName{i},'FontSize',labelsize+4);
     ax = gca;
     ax.FontSize = labelsize+2;
    else
     set(gca, 'XTickLabel','');
    end
    
   
    clear X1 X2 Y1* Y2* P
    
   end   % if j > counter+1
   
   if j == n
    counter = counter+1;
   end   
   
  end    % j-loop for columns
 end     % if i > counter
end      % i-loop for rows


end

