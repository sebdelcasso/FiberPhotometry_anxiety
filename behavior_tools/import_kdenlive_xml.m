function import_kdenlive_xml(filename)
[filepath,name,ext] = fileparts(filename);
s = xml2struct(filename);
txt_tmp = s.mlt.chain.property{42}.Text;
json_decoded = jsondecode(txt_tmp);
fod = fopen([filepath filesep name '_events.txt'],'w');
for i=1:size(json_decoded,1)
    fprintf(fod,"%d\n",json_decoded(i).pos);
end
fclose(fod);
    
