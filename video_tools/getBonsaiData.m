function bonsai_output = getBonsaiData(bonsaiPath)

    try 
        bonsai_output = getBonsaiData_v2(bonsaiPath);       
    catch
        warning("this migth be an old bonsai version file, but we were able to load it")
        try
            bonsai_output = getBonsaiData_v1(bonsaiPath);      
        catch
            warning("the bonsai file is not correct, please ask for the good template")
            bonsai_output = NaN;
        end
    end
end

function bonsai_output = getBonsaiData_v2(bonsaiPath)

    %% get Bonsai Data
    bonsai_output=[];

    if exist(bonsaiPath,'file')

        bonsai_output = table2struct(readtable(bonsaiPath),"ToScalar",true);
        bonsai_output.bodyX = bonsai_output.mouseX;
        bonsai_output.bodyY = bonsai_output.mouseY;
    %     bonsai_output=rmfield(bonsai_output,'mouseX');
    %     bonsai_output=rmfield(bonsai_output,'mouseY'); 


        figure();
        hold on
        plot(bonsai_output.optoPeriod);


    end
end

function bonsai_output = getBonsaiData_v1(bonsaiPath)

    %% get Bonsai Data
    bonsai_output=[];

    if exist(bonsaiPath,'file')
        bonsai_data = dlmread(bonsaiPath,' ',1,0);
        %bonsai_data(:,end)=[];
        bonsai_output={};
        fid = fopen(bonsaiPath, 'r');
        tline = fgets(fid);
        tline(end)=[];tline(end)=[];
        remain = tline;
        fields=[];
        nFields=0;
        while ~isempty(remain)
            [token,remain] = strtok(remain, ' ');
            nFields=nFields+1;
            fields{nFields} = token;
            cmd = sprintf('bonsai_output.%s=bonsai_data(:,nFields);', fields{nFields} );
            eval(cmd);
        end
        fclose(fid);
        bonsai_output.bodyX = bonsai_output.mouseX;
        bonsai_output.bodyY = bonsai_output.mouseY;
        rmfield(bonsai_output,'mouseX');rmfield(bonsai_output,'mouseY'); 


        figure();
        hold on
        plot(bonsai_output.optoPeriod);


    end

end