%% Function to recognise characters
% Author: Pushkar Kadam
% Date: 18/10/2017

%% Character Recognition
% Character recogntion is achieved by using the correlation method. For
% this the MATLAB function corr2() is used which gives a value. The value
% is set to be above 0.5 for identifying the similarity between the image
% recognised and the template images.
function plate_name = character_recognition(template,char_iden)
    plate = template;
    charac_iden = char_iden;
    
    temp_alpha = ['A', 'B', 'C', 'D','E','F', 'G','H','I','J'...
        'K','L', 'M','N', 'O','P', 'Q', 'R','S','T', 'U',...
        'V','W','X','Y','Z',...
        '0','1','2','3','4','5','6','7','9','8'];
    
    
    %temp_alpha = alphabets + numbers;
    
    plate_string = [];
    
    for idx = 1:size(char_iden,2)
        for idx2 = 1:size(plate,2)
            r = corr2(plate{idx2},charac_iden{idx});
            
            if r >= 0.56
               k = size(plate_string,2)+1;
               plate_string(k) = temp_alpha(idx2);
               break % break is used for stopping the loop once identified
            end
        end
    end
    plate_reg = plate_string;
    plate_name = char(plate_reg);
end