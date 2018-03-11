FaceDetector= vision.CascadeObjectDetector();
videoFileReader = videoinput('winvideo', 1);

    frame = getsnapshot(videoFileReader);
    BB = step(FaceDetector, frame);
    figure(2),imshow(frame);
    imwrite(frame,['dady.jpg']);
stop (videoFileReader);
