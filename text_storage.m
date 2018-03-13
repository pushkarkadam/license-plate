function text_storage(plate_number)
    fid = fopen('license.txt','wt');
    fprintf(fid,'-----------------------------------\n');
    fprintf(fid,'License plate number: ');
    fprintf(fid,plate_number);
    fprintf(fid,'\n-----------------------------------\n');
    fclose(fid);
end