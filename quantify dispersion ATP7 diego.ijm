
macro "Total and background measurement" {

//run("Z Project...", "projection=[Max Intensity] all");
getDimensions(w, h, channels, slices, frames);
setSlice(1);
for(m=0;m<frames;m++){
	resetMinAndMax();
	run("Measure");
percentage = 95;
nBins = 65653;
resetMinAndMax();
getHistogram(values, counts, nBins);
// find culmulative sum
nPixels = 0;
for (i = 0; i<counts.length; i++)
  nPixels += counts[i];
nBelowThreshold = nPixels * percentage / 100;
sum = 0;
for (i = 0; i<counts.length; i++) {
  sum = sum + counts[i];
  if (sum >= nBelowThreshold) {
    setThreshold(values[0], values[i]);
        i = 99999999;//break
  }
} 
	run("Create Selection");
	run("Measure");
	run("Select None");
	resetThreshold();
	run("Next Slice [>]");}
close();
close();
}