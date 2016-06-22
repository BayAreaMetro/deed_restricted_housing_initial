###Goal

The goal of the scripts in this folder is to check on the unit counts in the parent directory as produced by deduplicating various state and local data sources for affordable and deed restricted housing. We check the unit counts by comparing the counts in the American Housing survey to those from the other, combined sources. 

###Result

Below is a table of the unit counts in the AHS by SMSA and zone and those produced by the scripts in the parent directory.

Beneath the table, is an image of a map of the same values. 

Note that it is sorted in descending order of the `st_dev_diff` column, which is the number of standard deviations away from the AHS number the aggregated MTC number is. 

| zone | smsa | ahs_units | std_err | mtc_units | st_dev_diff | 
|------|------|-----------|---------|-----------|-------------| 
| 105  | 7400 | 1565      | 622     | 6393      | 7.768       | 
| 108  | 5775 | 1034      | 512     | 4588      | 6.94        | 
| 104  | 7400 | 294       | 202     | 1474      | 5.845       | 
| 4    | 7400 | 1944      | 664     | 5469      | 5.31        | 
| 106  | 5775 | 506       | 255     | 1766      | 4.943       | 
| 113  | 7360 | 358       | 304     | 1851      | 4.905       | 
| 3    | 7400 | 715       | 340     | 2376      | 4.891       | 
| 2    | 7360 | 1189      | 525     | 3726      | 4.832       | 
| 102  | 7400 | 1221      | 459     | 3394      | 4.736       | 
| 3    | 7360 | 8648      | 3554    | 21045     | 3.488       | 
| 112  | 7360 | 411       | 303     | 1452      | 3.442       | 
| 4    | 7360 | 231       | 167     | 807       | 3.44        | 
| 101  | 7360 | 893       | 487     | 2383      | 3.059       | 
| 103  | 7400 | 663       | 422     | 1512      | 2.011       | 
| 101  | 7400 | 1204      | 540     | 2277      | 1.987       | 
| 114  | 7360 | 1264      | 611     | 2421      | 1.894       | 
| 107  | 5775 | 5917      | 1473    | 8391      | 1.68        | 
| 6    | 7360 | 3656      | 1831    | 6381      | 1.488       | 
| 2    | 7400 | 4766      | 3034    | 7712      | 0.971       | 
| 110  | 5775 | 3348      | 1741    | 4629      | 0.736       | 
| 109  | 5775 | 8813      | 4476    | 6053      | -0.617      | 
| 105  | 5775 | 4705      | 2545    | 3348      | -0.533      | 
| 1    | 7360 | 6021      | 2856    | 7509      | 0.521       | 
| 103  | 5775 | 5275      | 2542    | 6565      | 0.508       | 
| 5    | 7400 | 1656      | 1178    | 2063      | 0.345       | 
| 1    | 7400 | 6531      | 3797    | 7777      | 0.328       | 
| 7    | 5775 | 22026     | 7492    | 20009     | -0.269      | 
| 5    | 7360 | 1810      | 1780    | 1535      | -0.154      | 
| 104  | 5775 | 781       | 449     | 747       | -0.076      | 
| 102  | 7360 | 1964      | 1567    | 2012      | 0.031       | 
| 111  | 5775 |           |         | 4297      |             | 
| 115  | 7360 |           |         | 2415      |             | 


###Map

![map of standard deviation in difference between ahs and mtc unit count](https://s3-us-west-2.amazonaws.com/landuse/housing/std_dev_diff_map3.png)

###Shapefile used for map
https://s3-us-west-2.amazonaws.com/landuse/housing/mtc_ahs_units_comparison.zip
