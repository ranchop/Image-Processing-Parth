% Sample Var
imvars = {'x16_15_13';'x21_23_98';'x56_34_87'};
TOF = [0;9;15];
RF23 = [89;98;87];

t = table(TOF,RF23);
t.Properties.RowNames = imvars;

