function image = image_capture(camera_name)
    camera = webcam(camera_name);
    image = snapshot(camera);
    clear('camera');
end