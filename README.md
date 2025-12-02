# CountWorms_Thermotaxis_Assay_Version2

📌 Overview
An automated ImageJ/Fiji macro for counting worms or dot markers in images. The tool divides images into 8 regions, provides regional statistics, and exports results in CSV(regional statistics) and TXT (Coordinates for individual worms )format. Perfect for biological research involving C. elegans or similar organisms.

✨ Features

🔄 Four-Step Workflow

Convert Worms/Dot Markers to Rough ROIs - Automated preprocessing and initial detection

Delete Multi-ROIs in Rectangle [F1] - Manual cleanup of Multi-ROIs

Count Final ROIs in 8 Regions - Statistical analysis with CSV and TXT export

Close ALL - Clean workspace management

🎯 Key Capabilities

Dual detection modes: Works with both natural worms and dot-marked samples

Perspective correction: Handles angled photos

Interactive thresholding: User-friendly parameter adjustment

8-region analysis: Divides images into equal sections for spatial distribution

CSV and TXT export: Ready-to-use data for further analysis

Batch processing friendly: Easy integration into automated workflows

📁 File Structure


```text
CountWorms/
├── CountWorms_StartupMacros.ijm    # Main macro file
├── DotMarker.jpg                   # Example dot marker image
├── worm.jpeg                       # Example worm image
├── Demo_DotMarker.mov              # Demonstration video (dot markers)
├── Demo_worm.mov                   # Demonstration video (worms)
└── README.md                       # This file
```

🚀 Quick Start

Prerequisites

Fiji (ImageJ2) installed

Installation

Download the CountWorms_StartupMacros.ijm file

Open Fiji and navigate to Plugins > Macros > Startup Macros

Copy the code in CountWorms_StartupMacros and paste into Startup Macro.ijm.

Restart Fiji for the right-click on any opened image to appear the menus.

📖 Usage Guide

Please refer to the 2 mov file.

📊 Output Format

CSV File (worm_count_results_[image]_[timestamp].csv)

Region,Count
1,15
2,12
3,18
4,14
5,16
6,13
7,17
8,11
Total,116


Coordinates for individual worms refer to TXT file.

🎥 Demonstration Videos

Two demonstration videos are included:

Demo_worm.mov - Counting natural worms

Demo_DotMarker.mov - Counting dot-marked samples

⚙️ Technical Details

Detection Parameters

Natural worms: Size 20-38 pixels, circularity 1.0

Dot markers: Size 20-Infinity pixels, circularity 0.5-1.0

Threshold: Adjustable via interactive dialog

Region Division

8 equal horizontal regions

Based on image width

Centroids used for region assignment



🤝 Contributing

Contributions are welcome! Please:

Fork the repository

Create a feature branch

Submit a pull request with detailed description


📧 Contact

Author: Shangguan Pingchuan
Email: zxlearly@gmail.com
Issues: Please use GitHub Issues for bug reports and feature requests

📄 License
MIT License - See LICENSE file for details.


