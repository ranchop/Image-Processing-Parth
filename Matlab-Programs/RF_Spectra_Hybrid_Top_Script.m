



%% Initialize
addpath(fullfile(fileparts(pwd),'Matlab-Functions-Image-Processing'));
data_folder = fullfile(fileparts(pwd),'Sample-Images\2015-11-17');
sample_filename = '11-18-2015_ 1_28_29.fits';

samp_data = load_img(fullfile(data_folder,sample_filename));
figure;
imshow(samp_data,[0 5]);



% % % % %% Trial 
% % % % t_threshhold = 3; % (s)
% % % % t_snippet = 'Date,18/11/15_01:06:49';
% % % % t_fits = '11-18-2015_ 1_06_50.fits';
% % % % t_snippet=t_snippet(6:end);
% % % % t_fits=t_fits(1:end-5);
% % % % t1_mat = datetime(t_snippet,'InputFormat','dd/MM/yy_H:mm:ss');
% % % % t2_mat = datetime(t_fits,'InputFormat','MM-dd-yyyy_HH_mm_ss');
% % % % t_diff = abs(datenum(t1_mat-t2_mat)*(3600*24));
% % % % t_diff < t_threshhold