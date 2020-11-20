function saveJson(data)

jsonStr = jsonencode(data);
fid = fopen(pwd+"/animation/data_hystory.json", 'w');
if fid == -1, error('Cannot create JSON file'); end
fwrite(fid, jsonStr, 'char');
fclose(fid);

end

