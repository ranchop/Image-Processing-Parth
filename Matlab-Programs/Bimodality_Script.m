%% Version Updates
% The final image will be stored at the data_folder
% Resquests here

%% User Defined Parameters
% data_folder = 'C:\Users\Elder\Dropbox (MIT)\BEC1\Image Data and Cicero Files\Data - Raw Images\2015\2015-11\2015-11-13';
data_folder = 'C:\Users\Parth Patel\Documents\GitHub\Image-Processing\Sample-Images\2015-11-12';
filename = '11-13-2015_ 0_46_57.fits';
% filename = filenames{8};
crop_width = 100;
image_min_max = [0,0.2];
ri = 2:40; ri = ri';
ri_cutoff = 2:35; ri_cutoff = ri_cutoff';
plot_ri_cutoff = 25;
range_ri_cutoff = [20 30];
mLi2 = 2*9.988346*10^(-27); %kg
kb = 1.38065*10^(-23);
tof = 15*10^(-3);
lnperpixel = 5.244*10^(-6);

%% Initialize
addpath(fullfile(fileparts(pwd),'Matlab-Functions-Image-Processing'));
fig_main = figure('Name',['Condensate Fraction Calculations of ',filename],'visible','off','NumberTitle','off','Units','pixels','Position',[50,50,1000,1000]);
fig_temp = figure('visible','off','NumberTitle','off','Units','pixels','Position',[50,50,1000,1000]);
try_again = 'Yes';
center_method = 'Circles';

%% Import data and crop
raw_data = load_img(fullfile(data_folder,filename));
try_again = 'Try Again';
while strcmp(try_again,'Try Again')
    fig_main.Visible = 'off'; fig_temp.Visible = 'off';
    figure(fig_temp); imshow(raw_data,image_min_max); fig_temp.Position = [1,1,1000,1000];
    [t1,t2] = getpts; crop_set = [t1-crop_width/2,t2-crop_width/2,crop_width,crop_width]; fig_temp.Visible = 'off';
    data = imcrop(raw_data,crop_set);
    figure(fig_main); subplot(2,2,1); imshow(data,image_min_max); 
    try_again = 'Continue';
    try_again = questdlg('Are you satisfied with the drop?','Questions: Crop','Try Again','Continue','Could be','Continue');
end

%% Find center using various fits
figure(fig_main);
try_again = 'Try Again';
while strcmp(try_again,'Try Again')
    center_method = questdlg('Which method to use for finding the center?','Method for finding center','Circles','Gaussian 2D','Manual','Circles');
    switch center_method
        case 'Circles'
            [center_fit, radius_fit] = imfindcircles(data,[5 50],'Sensitivity',0.90);
        case 'Gaussian 2D'
            [center_fit,~,~,radius_fit] = Gauss2DFit_temp(data,0,0);
            radius_fit = 0.5*(radius_fit(3)+radius_fit(4));
        case 'Manual'
            center_fit = [0,0];
            center_fit(1) = input('Enter the center x: ');
            center_fit(2) = input('Enter the center y: ');
            radius_fit = input('Enter the approximate radius: ');
        otherwise
            [center_fit,~,~,radius_fit] = Gauss2DFit_temp(data,0,0);
            radius_fit = 0.5*(radius_fit(3)+radius_fit(4));
    end
    % Plot the center boundary
    figure(fig_main); subplot(2,2,1); imshow(data,image_min_max);
%     viscircles(center_fit, radius_fit, 'LineStyle', ':','EnhanceVisibility',0);
%     viscircles(center_fit, ri(end), 'LineStyle', ':','EnhanceVisibility',0,'Color','b');
    viscircles(center_fit, radius_fit, 'LineStyle', ':');
    viscircles(center_fit, ri(end), 'LineStyle', ':');
    try_again = 'Continue';
    try_again = questdlg('Are you satisfied with the center?','Questions: Center','Try Again','Continue','Could be','Continue');
end

%% Radial Average and Gaussian fits to tail
% Compute radial average
[f_ri,ri] = ExtractRadialFunction_temp(data,center_fit,ri);
% Fit gaussian for various cutoff
fitres_cutoff = zeros(length(ri_cutoff),4);
fitdat_cutoff = cell(length(ri_cutoff),1);
cond_fracs_all = zeros(length(ri_cutoff),1);
for i = 1:length(ri_cutoff)
    [fitres_cutoff(i,1:3),fitdat_cutoff{i},~,fitres_cutoff(i,4)] = RadialGaussianFit_temp(ri, f_ri, 0, 0, ri_cutoff(i));
    cond_fracs_all(i) = (sum(f_ri-fitdat_cutoff{i}))/(sum(f_ri-fitres_cutoff(i,2)));
end

%% Make Plots for semi-final inspection
while plot_ri_cutoff > 6
    figure(fig_main);
    subplot(2,2,2); 
    plot(ri,f_ri,'b.',ri,fitdat_cutoff{ri_cutoff==plot_ri_cutoff},'g--');
    line([radius_fit,radius_fit],[min(f_ri),max(f_ri)],'Color','r');
    line([plot_ri_cutoff,plot_ri_cutoff],[min(f_ri),max(f_ri)],'Color','g');
    subplot(2,2,3); 
    plot(ri_cutoff,cond_fracs_all,'k*',ri_cutoff,fitres_cutoff(:,4)/(1.1*max(fitres_cutoff(:,4)))*10,'b.',ri_cutoff,fitres_cutoff(:,3)/(1.1*max(fitres_cutoff(:,3))),'g--',ri_cutoff,fitres_cutoff(:,1)/(1.1*max(fitres_cutoff(:,1))),'c--',ri_cutoff,fitres_cutoff(:,2)/(1.1*max(fitres_cutoff(:,2))),'r--');
    grid on; ylim([0 1]);
    subplot(2,2,4); plot(ri,f_ri-fitdat_cutoff{ri_cutoff==plot_ri_cutoff},'b.'); ylim([0,1.1*max(f_ri-fitdat_cutoff{ri_cutoff==plot_ri_cutoff})]);
    plot_ri_cutoff = inputdlg('Plot Fits for another cutoff radius. Cancel to exit.','Input for Cutoff Radius',1,{num2str(plot_ri_cutoff)});
    if length(plot_ri_cutoff) == 1
        plot_ri_cutoff = str2num(plot_ri_cutoff{1});
    else
        plot_ri_cutoff = 0;
    end
end

%% Select the range of cutoffs to keep
figure(fig_main); subplot(2,2,3);
line1 = line([range_ri_cutoff(1),range_ri_cutoff(1)],[0.1,0.9],'Color','k');
line2 = line([range_ri_cutoff(2),range_ri_cutoff(2)],[0.1,0.9],'Color','k');
while range_ri_cutoff(1) > 0
    t1 = find(ri_cutoff==range_ri_cutoff(1)); t2 = find(ri_cutoff==range_ri_cutoff(2));
    cond_frac_range = cond_fracs_all(t1:t2);
    cond_frac_mean = mean(cond_frac_range); cond_frac_std = std(cond_frac_range);
    sigma_range = fitres_cutoff(t1:t2,3);
    sigma_mean = mean(sigma_range); sigma_std = std(sigma_range);
    figure(fig_main); subplot(2,2,4); title(['Cond frac: ',num2str(cond_frac_mean), ' Sigma: ', num2str(sigma_mean)])
    subplot(2,2,3); delete(line1); delete(line2);
    line1 = line([range_ri_cutoff(1),range_ri_cutoff(1)],[0.1,0.9],'Color','k');
    line2 = line([range_ri_cutoff(2),range_ri_cutoff(2)],[0.1,0.9],'Color','k');
    temp = inputdlg({'Min cutoff radius','Max cutoff radius'},'Range of cutoff radii',2,{num2str(range_ri_cutoff(1)),num2str(range_ri_cutoff(2))});
    if length(temp) == 2
        range_ri_cutoff(1) = str2num(temp{1}); range_ri_cutoff(2) = str2num(temp{2});
    else
        range_ri_cutoff(1) = 0;
    end
end

%% Finish up
figure(fig_main);
subplot(2,2,1); title(['Image: ',filename],'interpreter','none');
subplot(2,2,2); title('Radial average and fits');
subplot(2,2,3); title('Black**: Condensate Fraction    Blue... \chi^2');
print(fig_main,fullfile(data_folder,[filename(1:length(filename)-5),'.tiff']),'-dtiffn');
disp(['Cond Frac: ', num2str(cond_frac_mean*100), ' +- ', num2str(cond_frac_std*100)]);
disp(['Sigma    : ', num2str(sigma_mean), ' +- ', num2str(sigma_std)]);
temperature =  ( mLi2 * (sigma_mean*lnperpixel)^2 ) / (kb * tof^2);
disp(['Temperature: ', num2str(temperature*10^9)]);
clipboard('copy',[num2str(cond_frac_mean*100),';',num2str(sigma_mean),';',num2str(temperature*10^9)]);
keepdata{index,1} = filename; 
keepdata{index,2} = cond_frac_mean*100; 
keepdata{index,3} = sigma_mean;
keepdata{index,4} = temperature*10^9;
index = index + 1;

%% Clean up
clear vars i t1 t2 temp try_again line1 line2 ans;
close(fig_temp);

