%% Creating Arduino Object
%arduino_board = arduino('COM38','Uno','Libraries','JRodrigoTech/HCSR04');
arduino_board = arduino();

%% Creating Sensor object
sensor = addon(arduino_board, 'JRodrigoTech/HCSR04','D12','D13');

%% Main License plate recognition algorithm
threshold_distance = 0.05; % Distance from the sensor to the object in metres

while true
    sensor_distance = readDistance(sensor);
    fprintf('Current distance is %.4f meters\n',sensor_distance);

    %sensor_distance = convlength(sensor_distance,'m','in');

    if (sensor_distance <= threshold_distance)
        % Capturing the images from the cameras
        front_image = image_capture('USB Camera #2');
        left_image = image_capture('USB Camera #3');
        right_image = image_capture('USB Camera #4');

        % License plate recognition sub-routine
        license_plate = npr(front_image);

        % Directory sub-routine
        create_directory(license_plate, front_image, left_image, right_image);
        break;
    else
        continue;
    end
end
