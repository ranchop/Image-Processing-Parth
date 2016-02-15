%% Needed variables
% SGE.value = SideGreenEvapValue
% EoSData

%% Keep only the data for SGE.value
SGE.data = EoSData(EoSData.SideGreenEvap == SGE.value,:);

%% Process Data with different SeqModes

for SeqModeValue = [19 21 18 22]
    SGE.SMV.data = SGE.data(SGE.data.SeqMode == SeqModeValue,:);
    temp = 1/size(SGE.SMV.data,1) * load_img(SGE.SMV.data.ImageName{1});
    for imnum = 2:size(SGE.SMV.data,1)
        temp = temp + 1/size(SGE.SMV.data,1) * load_img(SGE.SMV.data.ImageName{imnum});
    end
    
end

%% Clearvars
clearvars SeqModeValue