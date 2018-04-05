function main()
    %% Creating Arduino Object
    arduino_board = arduino('COM38','Uno','Libraries','JRodrigoTech/HCSR04');
    
    %% Creating Sensor object
    sensor = addon(arduino_board, 'JRodrigoTech/HCSR04','D12','D13');
    
    %% Main License plate recognition algorithm
    threshold_distance = 4;
    
    while true
        sensor_distance = readDistance(sensor);
        fprinf('Current distance is %.4f meters\n',sensor_distance);
        
        sensor_distance = convlenght(sensor_distance,'m','in');
        
        if (sensor_distance >= threshold_distance)
            % TODO: Add code here
            break;
        else
            continue;
    end
end