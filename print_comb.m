function print_comb(comb, filename)
    fileID = fopen(filename,'a');
    fprintf(fileID,'strong statement about the structure is not valid\n');
    for cnt = 1:length(comb)
        dmult = strcat(repmat('%d,',1,length(comb(cnt).vars - 1)),'%d\n');
        fmult = strcat(repmat('%f,',1,length(comb(cnt).vars - 1)),'%f\n');
        fprintf(fileID, dmult, comb(cnt).vars);
        fprintf(fileID, fmult, comb(cnt).values);
        %fprintf(fileID,'%6.2f %12.8f\n',A);
    end
    fclose(fileID);
end