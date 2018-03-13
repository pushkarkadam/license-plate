%% Number Plate Recognition function
% Author: Pushkar Kadam
% Date: 15/10/2017

%% Importing image
function plate_number =  npr(image)
    %% Importing the template images
    template = temp_read();

    %% Resizing image
    % It was important to resize the image otherwise MATLAB keeps on giving
    % error messages and automatically resizes the image to 50 percent
    % The image taken are of high resolution and therefore they are resized in
    % this code to 50 percent of its actual size.
    image = imresize(image,[600 800]);

    %% Converting Color image to Gray scale image
    % The color image obtained is usually a 3 dimensional matrix. Most of the
    % operations that are concerned with the image processing are performed on
    % 2 dimensional matrix.
    gray_image = rgb2gray(image);

    %% Mathematical Morphology to detect edges
    % Mathematical morphology is used for edge detection

    %% Converting the image into binary image
    % The reason for using binary image is that it will later be used to
    % multiply with another binary image to obtained the characters of the
    % number plate.
    threshold_value = graythresh(gray_image);
    binary_image = im2bw(gray_image,threshold_value); %Code line for transforming image into binary

    %% Edge detection using Sobel method
    edge_image = edge(gray_image,'sobel');

    %% Code for dilating the image
    % Dilation of the image enhances the borders of the image
    SE = strel('square',3);

    edge_image = imdilate(edge_image, SE);

    %% Filling the edges with white color
    fill_image = imfill(edge_image,'holes');

    %% Removing the other edges that are not inside the number plate region
    eroded_image = fill_image;
    
    %% Using erode to get rid of unnecessary dots on the image
    % This command is used three times to get rid of most of the dots
    for x = 1:3
        eroded_image = imerode(eroded_image,SE);
    end

    %% Getting the characters on the number plate
    % The binary image obtained after converting the B&W image is multiplied
    % with the image obtained after eroding. This ensures that all the black
    % regions which are of the value 0 are multiplied with 1 to give 0 and the
    % regions with the value of 1 gives the black color. The characters in the
    % number plate were black in color therefore they gave the results of black
    % on white in the result of this image.
    % Always multiple two binary images.
    character_image = binary_image.*eroded_image;

    %% Character segmentation
    % This is very much important.
    % What I did here is that I reversed the image turning all the black to
    % white and vice versa. The reason for doing so was that BoundingBox was
    % able to identify the white characters on a black background. Then, once
    % the inversion was obtained, the white background persisted and it was
    % necessary to turn it into black. So, I used imclearborder command to get
    % rid of all the background area except the region of interest. I think it
    % got rid of all the background and kept only the numbers. However, there
    % were many dots on the screen. These dots were being identified by the
    % BoundingBox algorithm. So, I used imerode function to get rid of those
    % dots several times. But, it also thinned the characters to a point where
    % it seperated some lines of the character 'K'. Therefore, I had to apply
    % imdilate function to thicken whatever was left out of the characters. I
    % was not able to get rid of the white dot that exists between the number
    % plates. If we create a template for that dot, then maybe even that dot
    % can be identified.
    character_image = ~character_image;
    character_image_erode = imclearborder(character_image);
    
    for x = 1:3
        character_image_erode = imerode(character_image_erode,SE);
    end

    dilate_character_image = character_image_erode;
    
    for x = 1:4
        dilate_character_image = imdilate(dilate_character_image,SE);
    end

    %% Using Bounding Box
    % s is a structure where each element in this structure contains a
    % BoundingBox that encapsulates an object detected in the image. The
    % BoundingBox property for each object is a 4 element array [x y w h] where
    % (x,y) denotes column and row co-ordinates of the upper left corner of the
    % bounding box and (w,h) denote the width and height of the BoundingBox
    structure = regionprops(dilate_character_image, 'BoundingBox');

    %% 4 column matrix
    % Creating 4 column matrix that encapsulate all of these BoundingBox
    % properties together, where each row denotes a single bounding box
    % It is essential to round the values because in order to extract the
    % letters from the image, we need to use the integer co-ordinates which is
    % the form of natural representation of the image.

    bb = round(reshape([structure.BoundingBox],4,[]).');

    %% Creating the bounding box rectangles
    % numel(s) returns the total number of elements that are present in that
    % matrix. It can be equivalent to using prod(size(s))
    %imshow(ss1)
    for idx = 1:numel(structure)
        rectangle('Position', bb(idx,:),'edgecolor','red');
    end

    %% Extracting the characters to a cell
    % Extracting all the characters and placing them in the cell array. The
    % reason for using the cell array is that the character size are uneven and
    % therefore, putting them in a cell array will accommodate for the
    % different sizes.
    % By simply looping over every bounding box, bounding box pixels can be
    % extracted to each character and it can be placed into a cell array.
    characters = cell(1,numel(structure));
    for idx = 1:numel(structure)
        characters{idx} = dilate_character_image(bb(idx,2):bb(idx,2)+bb(idx,4)-1, bb(idx,1):bb(idx,1)+bb(idx,3)-1);
    end

    %% Resizing all the images
    % Resizing is essential for template matching
    for idx = 1:numel(structure)
        characters{idx} = imresize(characters{idx}, [57 42]);
    end
    
    %% Character recognition code
    plate_number = char_reg(template,characters);

    %% Stores the license plate text in a txt file
    fid = fopen('license.txt','wt');
    fprintf(fid,'-----------------------------------\n');
    fprintf(fid,'License plate number: ');
    fprintf(fid,plate_number);
    fprintf(fid,'\n-----------------------------------\n');
    fclose(fid);
end


