  
clc;
close all;




    
    %snapshot
    data = imread('amma.jpg');
    
    % red object tracker
    red = imsubtract(data(:,:,1), rgb2gray(data));
  green = imsubtract(data(:,:,2), rgb2gray(data));
     blue = imsubtract(data(:,:,3), rgb2gray(data));
    %filter out noise using median filter
  red = medfilt2(red, [3 3]);
   blue = medfilt2(blue, [3 3]);
   green = medfilt2(green, [3 3]);
    % gray to binary 
    red = im2bw(red,0.18);
     blue = im2bw(blue,0.18);
     green = im2bw(green,0.18);
    
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

% Both the loops end here.

% Stop the video aquisition.


% Flush all the image data stored in the memory buffer.


clear all  % Clear all values



