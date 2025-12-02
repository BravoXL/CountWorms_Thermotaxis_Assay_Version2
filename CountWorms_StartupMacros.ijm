// -----------------------------------------------------------------------------
// Macro: Count worms in 8 regions
// Author: Shangguan Pingchuan
// Email:  zxlearly@gmail.com
// Date:   2025-12-2
// 
//Description: Input an image with worms or dotmarker picture, and output the rough ROI.




// Make sure all sub-windows are closed, especially the Results and Log windows.

// --------> Set F1 as the short cut for Step2 Delete Multi-ROIs in Your Rectangle
var pmCmds = newMenu("Popup Menu",
	newArray("Help...", "Rename...", "Duplicate...", "Original Scale",
	"Paste Control...", "-", "Record...", "Capture Screen ", "Monitor Memory...",
	"Find Commands...", "Control Panel...", "Startup Macros...", "Search...", "-","Step1 Convert worms to Rough ROIs","Step1 Convert Dot Markers to Rough ROIs", "Step2 Delete Multi-ROIs in Your Rectangle [F1]", "Step3 Count Final ROIs in 8 Regions",
	"Step4 Close ALL"));
	
	
	
	
	
// --------> Steps

//Description: Input an image with worms, and output the rough ROI.	
macro "Step1 Convert worms to Rough ROIs" {



// Step 1: user must manually drag-and-drop the photo, then click “Run this macro”.
waitForUser("Step 1 Open image. File > Open or drag it into Fiji, then press OK");


origTitle = getTitle();
//run("Duplicate...");

run("Interactive Perspective");

waitForUser("Step 2 Free Transform, then press OK");

//run("Duplicate...");
run("Select None");

setTool("rectangle");
waitForUser("Step 3 Rectangle. Make a rectangle select your plate, mind the width of the division at edge is the same as in the center，then OK");

run("Copy");
run("Crop");

run("Rotate 90 Degrees Right");
//run("Duplicate...");


run("8-bit");
Title8bit = getTitle();
//run("Duplicate...");
run("Duplicate...", "title=MyCopy");
//getTitle

setAutoThreshold("Default dark no-reset");

run("Threshold...");
setThreshold(50, 160);
// Pause macro execution until user sets threshold, clicks “Apply”, and closes the Threshold dialog


waitForUser("Step 4. Set the threshold so worms appear red, tick +Dark background，+Don't reset range，+Raw values，click APPLY, then press OK");
// Convert to mask


run("Convert to Mask");
run("Skeletonize");



waitForUser("Step 5. Analyze skeletion suggestion：size=20-38 circularity=1，tick all the check box.Press OK");


//run("Analyze Particles...");


run("Analyze Particles...", "size=20-38 circularity=1 display exclude clear include summarize overlay add composite record");

roiManager("Show All without labels");

/////------

if (!getBoolean("Accept this particle analysis? Click NO to adjust manually.")) {
    // 清除刚生成的 ROI 和结果
    roiManager("Delete");
    run("Clear Results");
    
    // 手动重新分析
    waitForUser("Now adjust settings in the Analyze Particles dialog, then click OK here.");
    run("Analyze Particles...");
}
/////------





imageGenerateROIs = getTitle();

roiManager("Show All without labels");
//


roiManager("Show None");

// Switch to the 8-bit image and apply the ROIs from the binary image
selectImage(Title8bit);

roiManager("Show All without labels");

waitForUser("Step 6. Reminder: Only after press OK, can you use other plugins! next step is Manually edit ROIs as needed. Add: Magical bar, press ADD（cmd+t） or DEL by plugin:（draw a selection, then plugins->macros->Delete Multi-ROIs). ");

close(imageGenerateROIs);


if (isOpen("Threshold")) {selectWindow("Threshold"); run("Close");}
if (isOpen("Results")) {selectWindow("Results"); run("Close");}
if (isOpen("Summary")) {selectWindow("Summary"); run("Close");}

}





/////////////////////////////////////////////////////////zxl
macro "Step1 Convert Dot Markers to Rough ROIs" {
	// -----------------------------------------------------------------------------
// Macro: Step1 Origin DotMarker to Rough ROI.ijm
// Author: Shangguan Pingchuan
// Email:  zxlearly@gmail.com
// Date:   2025-11-27
// 
//Description: Input an image with dot-marked worms, and output the rough ROI.

// Make sure all sub-windows are closed, especially the Results and Log windows.


// Step 1: user must manually drag-and-drop the photo, then click “Run this macro”.
waitForUser("Step 1 Open image. File > Open or drag it into Fiji, then press OK");


origTitle = getTitle();
//run("Duplicate...");

run("Interactive Perspective");

waitForUser("Step 2 Free Transform, then press OK");

//run("Duplicate...");
run("Select None");

setTool("rectangle");
waitForUser("Step 3 Rectangle. Make a rectangle select your plate, mind the width of the division at edge is the same as in the center，then OK");

run("Copy");
run("Crop");

run("Rotate 90 Degrees Right");
//run("Duplicate...");


run("8-bit");
Title8bit = getTitle();
//run("Duplicate...");
run("Duplicate...", "title=MyCopy");
//getTitle

setAutoThreshold("Default dark no-reset");

run("Threshold...");
setThreshold(0, 80);
// Pause macro execution until user sets threshold, clicks “Apply”, and closes the Threshold dialog


waitForUser("Step 4. Set the threshold so worms appear red, tick +Dark background，+Don't reset range，+Raw values，click APPLY, then press OK");
// Convert to mask


run("Convert to Mask");
run("Watershed");

waitForUser("Step 5. Analyze Particles suggestion：area:20-700，0.5-1，tick all the check box.Press OK");


//run("Analyze Particles...");
run("Analyze Particles...", "size=20-Infinity circularity=0.50-1.00 display exclude clear include summarize overlay add composite record");

roiManager("Show All without labels");

/////------

if (!getBoolean("Accept this particle analysis? Click NO to adjust manually.")) {
    // 清除刚生成的 ROI 和结果
    roiManager("Delete");
    run("Clear Results");
    
    // 手动重新分析
    waitForUser("Now adjust settings in the Analyze Particles dialog, then click OK here.");
    run("Analyze Particles...");
}
/////------





imageGenerateROIs = getTitle();

roiManager("Show All without labels");
//


roiManager("Show None");

// Switch to the 8-bit image and apply the ROIs from the binary image
selectImage(Title8bit);

roiManager("Show All without labels");

waitForUser("Step 6. Reminder: Only after press OK, can you use other plugins! next step is Manually edit ROIs as needed. Add: Magical bar, press ADD（cmd+t） or DEL by plugin:（draw a selection, then plugins->macros->Delete Multi-ROIs). ");

close(imageGenerateROIs);


if (isOpen("Threshold")) {selectWindow("Threshold"); run("Close");}
if (isOpen("Results")) {selectWindow("Results"); run("Close");}
if (isOpen("Summary")) {selectWindow("Summary"); run("Close");}

}



//////////////////////////////////////////zxl

// -----------------------------------------------------------------------------
// Macro: Delete Multi-ROIs in Your Rectangle.ijm
// Author: Shangguan Pingchuan
// Email:  zxlearly@gmail.com
// Date:   2025-11-26
//
// Description:
// Draw any selection (rectangle only) and run the macro.
// All ROIs in the ROI Manager that overlap this selection will be deleted.
// No need to add the selection to the ROI Manager.
// Tested on ImageJ 1.54g
// -----------------------------------------------------------------------------

macro "Step2 Delete Multi-ROIs in Your Rectangle [F1]" {
    // 1. Ensure an active selection exists
    if (selectionType == -1)
        exit("Please draw a selection that encloses the ROIs you want to remove.");

    // 2. Save the current selection as an overlay for later restoration
    run("Add Selection...", "name=temp");

    // 3. Get the bounding box of the user-drawn selection
    getSelectionBounds(x0, y0, w0, h0);

    // 4. Loop through all ROIs in the ROI Manager (backwards to avoid index shifting)
    n = roiManager("count");
    if (n == 0) exit("ROI Manager is empty.");

    for (i = n - 1; i >= 0; i--) {
        roiManager("select", i);          // activate the i-th ROI
        getSelectionBounds(x1, y1, w1, h1); // get its bounding box

        // 5. Delete the ROI if the two rectangles overlap
        if (x0 < x1 + w1 && x0 + w0 > x1 && y0 < y1 + h1 && y0 + h0 > y1) {
            roiManager("delete");
        }
    }

    // 6. Restore the original selection and clean up the overlay
    run("Restore Selection", "overlay=temp");
    run("Remove Overlay");
    roiManager("Show All");   // refresh the overlay display
    if (isOpen("Log")) {selectWindow("Log"); run("Close");}
}

////////////////////////////////////////zxl
// -----------------------------------------------------------------------------
// Macro: Step3 Count Final ROIs in 8 Regions.ijm
// Author: Shangguan Pingchuan
// Email:  zxlearly@gmail.com
// Date:   2025-11-26
//
// Description:
// Count Final ROIs in 8 Regions
// Tested on ImageJ 1.54g
// -----------------------------------------------------------------------------


macro "Step3 Count Final ROIs in 8 Regions"{
	//waitForUser("！！！close the log window！and press OK.");
	    if (isOpen("Log")) {selectWindow("Log"); run("Close");}
	
//INPUT：1 picture with final ROIs. OUTPUT: count the ROIs in 8 Regions and csv and txt file.
// One-click numbering all ROIs and output total count (start from 1) 
n = roiManager("count");
for (i = 0; i < n; i++) {
   roiManager("Select", i);
   roiManager("Rename", "ROI_" + (i + 1));  // numbering starts at 1
}
print("Detected Worms " + n);

//----------- Start 8-region statistics
// Get image dimensions
getDimensions(width, height, channels, slices, frames);

// Number of horizontal divisions
nDiv = 8;
regionWidth = width / nDiv;

// Count ROIs
nROI = roiManager("count");
if (nROI == 0) exit("No ROIs in ROI Manager!");

// Init arrays
regionCounts = newArray(nDiv);
regionCoords = newArray(nDiv);
for (i = 0; i < nDiv; i++) {
   regionCounts[i] = 0;
   regionCoords[i] = "";
}

// Process each ROI
for (i = 0; i < nROI; i++) {
   roiManager("Select", i);
   Roi.getBounds(rx, ry, rw, rh);
   xc = rx + rw / 2;
   yc = ry + rh / 2;

   regionIndex = floor(xc / regionWidth);
   if (regionIndex >= nDiv) regionIndex = nDiv - 1;
   if (regionIndex < 0) regionIndex = 0;

   regionCounts[regionIndex]++;

   coordStr = "(" + d2s(xc,1) + ", " + d2s(yc,1) + ")";
   if (regionCounts[regionIndex] == 1)
       regionCoords[regionIndex] = coordStr;
   else
       regionCoords[regionIndex] = regionCoords[regionIndex] + "; " + coordStr;
}

// Total count
totalCount = 0;
for (i = 0; i < nDiv; i++) totalCount += regionCounts[i];

// Print results
print("\\Clear");
//print("========== Regional Count ==========");
//for (i = 0; i < nDiv; i++) {
//   xStart = i * regionWidth;
//   xEnd = (i+1) * regionWidth;
//   print("Region " + (i+1) + " (X=" + d2s(xStart,0) + "-" + d2s(xEnd,0) + "): " + regionCounts[i] + " worms");
//   if (regionCounts[i] > 0) print("  Centroids: " + regionCoords[i]);
//}
print("==================================");
print("Total: " + totalCount + " worms");

print("========Concise Version 1==========================");
for (i = 0; i < nDiv; i++) {
   xStart = i * regionWidth;
   xEnd = (i+1) * regionWidth;
   print((i+1) + ", " + regionCounts[i]);
   if (regionCounts[i] > 0) print(regionCoords[i]);
}
print("Total: " + totalCount);

print("========Concise Version 2==========================");
for (i = 0; i < nDiv; i++) {
   xStart = i * regionWidth;
   xEnd = (i+1) * regionWidth;
   print((i+1) + ", " + regionCounts[i]);
}
print("Total: " + totalCount);

//-------------- Save as CSV
//waitForUser("Last step – choose the folder to save data. Press OK to start.");
//dir = getDirectory("/Users/xiaolinzhang/Desktop/zxl_code/zxl_fiji_macro/zxl_ttx_countWorms/countResults/");   // user home directory
dir = getDirectory("Choose folder for results");
origTitle = getTitle();  
t = getTime();
t1 = d2s(t,0); 
savePath = dir + "worm_count_results_" + origTitle + "_" + t1 + ".csv";

file = File.open(savePath);
print(file, "Region,Count");

for (i = 0; i < nDiv; i++) {
   xStart = i * regionWidth;
   xEnd = (i+1) * regionWidth;
   print(file, (i+1) + "," + regionCounts[i]);
}
print(file, "Total," + totalCount);
File.close(file);
print("Results saved to: " + savePath);

//-------------- Save detailed log
saveAs("Text", dir + "worm_count_results_" + origTitle + "_" + t1 + "Log.txt");

//waitForUser("Result here: " + savePath);
//close all the pictures.

}


//////////////////////////////////////zxl
// -----------------------------------------------------------------------------
// Macro: Step3 Count Final ROIs in 8 Regions.ijm
// Author: Shangguan Pingchuan
// Email:  zxlearly@gmail.com
// Date:   2025-11-26
//
// Description:
// close all the pictures and listed windows.
// Tested on ImageJ 1.54g
// ----
macro "Step4 Close ALL"{
	
////close all the pictures and listed windows.
run("Close All")
if (isOpen("ROI Manager")) {selectWindow("ROI Manager"); run("Close");}
if (isOpen("Threshold")) {selectWindow("Threshold"); run("Close");}
if (isOpen("Results")) {selectWindow("Results"); run("Close");}
if (isOpen("Summary")) {selectWindow("Summary"); run("Close");}
if (isOpen("Log")) {selectWindow("Log"); run("Close");}
}


