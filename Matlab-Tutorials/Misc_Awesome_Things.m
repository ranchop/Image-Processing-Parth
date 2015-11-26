%     endindex = strfind(folderpath,'Dropbox'); endindex = endindex + strfind(folderpath(endindex:end),'\') - 1;
%     obj.dropbox_path = folderpath(1:endindex);