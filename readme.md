##Goal

The goal of this repository is to output a CSV with the locations and known unit counts of deed restricted affordable housing units from a number of available data sources. 

##Data Sources

Data sources on deed restricted affordable housing the bay area area listed in data_sources.json

##Methods

1 Conform each source to the same schema (`conform.py`)
2 Geocode full addresses for which there are no latitude and longitude in the source ('geocode.py')
3 Deduplicate records ('deduplicate.py')
4 Summarize overlap ('summarize.py')
5 Output chosen records with location and unit based on a heuristic ('get_units.py')

##Result

In order, we recommend users start with the `housing_locations_unit_count.csv`, which is the input to `bayarea_urbansim`. For further information on the chosen data, see `full_selected_cluster_results.csv.` Further information can be found in the comments and data as one works back through the methods above.

##Thanks

Thanks to Pedro Galvao, Nathaniel Decker, Max Gardener, and Michael Reilly for their invaluable data and input in developing a method for developing this list. 
