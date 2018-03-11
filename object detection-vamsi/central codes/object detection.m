clear all;
close all;
  
    %snapshot
    data = imread('33a.jpg');
    
    % red object tracker
    red = imsubtract(data(:,:,1), rgb2gray(data));
  green = imsubtract(data(:,:,2), rgb2gray(data));
     blue = imsubtract(data(:,:,3), rgb2gray(data));
    %filter out noise using median filter
  red = medfilt2(red, [3 3]);
   blue = medfilt2(blue, [3 3]);
   green = medfilt2(green, [3 3]);
    % gray to binary 
    red = im2bw(red,0.09);
     blue = im2bw(blue,0.09);
     green = im2bw(green,0.09);
    
    % Remove all those pixels less than 300px
    red = bwareaopen(red,300);
     blue = bwareaopen(blue,300);
    green = bwareaopen(green,300);
    
    % labelling
    bwred = bwlabel(red, 8);
     bwblue = bwlabel(blue, 8);
     bwgreen = bwlabel(green, 8);
    
    % Here we do the image blob analysis.
    % We get a set of properties for each labeled region.
    statsred = regionprops(bwred, 'BoundingBox', 'Centroid');
      statsblue = regionprops(bwblue, 'BoundingBox', 'Centroid');
        statsgreen = regionprops(bwgreen, 'BoundingBox', 'Centroid');
    % Display the image
    imshow(data)
    
    hold on
    length(statsred)
    
    %This is a loop to bound the red and blue objects in a rectangular box.
    for object = 1:length(statsred)
        bb = statsred(object).BoundingBox;
        bc = statsred(object).Centroid;
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
        plot(bc(1),bc(2), '-m+')
        a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2)))));
        set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
        
  
    end
    
     for object = 1:length(statsblue)
        bb = statsblue(object).BoundingBox;
        bc = statsblue(object).Centroid;
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
        plot(bc(1),bc(2), '-m+')
        a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2)))));
        set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
        sprintf('blue');
     end
       for object = 1:length(statsgreen)
        bb = statsgreen(object).BoundingBox;
        bc = statsgreen(object).Centroid;
        rectangle('Position',bb,'EdgeColor','r','LineWidth',2)
        plot(bc(1),bc(2), '-m+')
        a=text(bc(1)+15,bc(2), strcat('X: ', num2str(round(bc(1))), '    Y: ', num2str(round(bc(2)))));
        set(a, 'FontName', 'Arial', 'FontWeight', 'bold', 'FontSize', 12, 'Color', 'yellow');
        sprintf('green');
    end
    
    
    hold off
    

pause(0.7);





%%

%specific object detection enters

%reading images
boximage =imread('2.jpg');
figure;
imshow(boximage);
pause(0.7);
boximage1=rgb2gray(boximage);
figure;
imshow(boximage1);
title('image of a box');
pause(0.7);




%%
sceneimage=imread('2a.jpg');
figure;
imshow(sceneimage);
pause(0.7);
sceneimage1=rgb2gray(sceneimage);
figure;
imshow(sceneimage1);
title('image of a scene');
pause(0.7);
%features




%%

boxpoints =detectSURFFeatures(boximage1);
figure;
imshow(boximage1);
title('title1');
hold on;
plot(selectStrongest(boxpoints, 100));
pause(0.7);
%%
scenepoints =detectSURFFeatures(sceneimage1);
figure;
imshow(sceneimage1);
title('title2');
hold on;
plot(selectStrongest(scenepoints,100));
pause(1);

%descriptors
[boxFeatures,boxpoints]=extractFeatures(boximage1,boxpoints);
[sceneFeatures,scenepoints]=extractFeatures(sceneimage1,scenepoints);
%%
%matching features
boxpairs=matchFeatures(boxFeatures,sceneFeatures);
matchedboxpoints=boxpoints(boxpairs(:,1),:);
matchedscenepoints=scenepoints(boxpairs(:,2),:);
figure;
showMatchedFeatures(boximage1,sceneimage1,matchedboxpoints,matchedscenepoints,'montage');
title('including outliers');
pause(1);
%%
% removing noise

[tform,inlierboxpoints,inlierscenepoints]=estimateGeometricTransform(matchedboxpoints,matchedscenepoints,'affine');
 figure;
showMatchedFeatures(boximage1,sceneimage1,inlierboxpoints,inlierscenepoints,'montage');
 title('matchednpoints'); 
 pause(0.7);
 %%
 % making box for detected
 
 boxpolygon=[1,1;size(boximage1,2),1;size(boximage1,2),size(boximage1,1);1,size(boximage1,1);1,1];
 newboxpolygon=transformPointsForward(tform,boxpolygon);
  figure;

subplot(1,2,1);
imshow(boximage);

subplot(1,2,2);

 imshow(sceneimage);
 hold on;
 line(newboxpolygon(:,1),newboxpolygon(:,2),'color','r','LineWidth',2);

 title('detected box');
 
 %denoting in voice form
 
 pause(1);
 defaultString = 'object has been detected';
NET.addAssembly('System.Speech');
obj = System.Speech.Synthesis.SpeechSynthesizer;
obj.Volume = 100;
Speak(obj, defaultString );




