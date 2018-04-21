function create_directory(license_plate, front_image, left_image, right_image)
    mkdir(license_plate);
    cd(license_plate);
    % Storing the license plate number in txt file
    fid = fopen('license.txt','wt');
    fprintf(fid,'-----------------------------------\n');
    fprintf(fid,'License plate number: ');
    fprintf(fid,license_plate);
    fprintf(fid,'\n-----------------------------------\n');
    fclose(fid);
    % Storing images in the directory
    imwrite(front_image,'front_image.jpeg');
    imwrite(left_image,'left_image.jpeg');
    imwrite(right_image,'right_image.jpeg');
end