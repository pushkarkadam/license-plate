function image = image_capture(camera_name)
    camera = webcam(camera_name);
    pause(2)
    image = snapshot(camera);
    pause(5);
    clear('camera');
end