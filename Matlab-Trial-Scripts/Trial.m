figure;
% c = colormap default;
cond = plotdata(:,3) > 10; cond = cond+1;
colormap winter;
scatter(plotdata(:,1),plotdata(:,2),[],cond,'filled');
% scatter(plotdata(:,1),plotdata(:,2),[],plotdata(:,3)/100,'filled');
xlabel('1/kfa'); ylabel('T*/Tf');
title('Phase diagram BEC side @ 740G');
grid on;










% % % % % % % % data_folder = 'C:\Users\Elder\Dropbox (MIT)\BEC1\Image Data and Cicero Files\Data - Raw Images\2015\2015-11\2015-11-10';
% % % % % % % % 
% % % % % % % % crop_width = 120;
% % % % % % % % crop_set = [121-crop_width/2, 423-crop_width/2, crop_width, crop_width ];
% % % % % % % % figure('Units','pixels','Position',[50,50,700,700]);
% % % % % % % % for i = 1:length(filenames)
% % % % % % % %     data = load_img_2(fullfile(data_folder,filenames{i}));
% % % % % % % %     data = imcrop(data,crop_set);
% % % % % % % %     subplot(3,3,i); imshow(data,[0 0.4]); title(['TOF 12ms Green-',num2str(green(i)),'V']);
% % % % % % % % end
% % % % % % % % 
% % % % % % % % crop_width = 120;
% % % % % % % % crop_set = [121-crop_width/2, 312-crop_width/2, crop_width, crop_width ];
% % % % % % % % figure('Units','pixels','Position',[50,50,700,700]);
% % % % % % % % for i = 1:length(filenames2)
% % % % % % % %     data = load_img_2(fullfile(data_folder,filenames2{i}));
% % % % % % % %     data = imcrop(data,crop_set);
% % % % % % % %     subplot(3,3,i); imshow(data,[0 0.4]); title(['R.R 12ms Green-',num2str(green(i)),'V']);
% % % % % % % % end

% % % % Convert Voltage to B
% % % Bf = @(FB_volt) 206*FB_volt - 42.5;
% % % 
% % % figure('Units','pixels','Position',[50,50,400,300]);
% % % scatter(Bf(RR_bot),atom_rr./atom_tof,'b*');
% % % title('R.R. Bottom vs Atom Loss');
% % % xlabel('R.R. Bottom in Gauss');
% % % ylabel('Atoms in R.R. / Atoms in TOF');
% % % axis.style = 'tight';
% % % grid on;