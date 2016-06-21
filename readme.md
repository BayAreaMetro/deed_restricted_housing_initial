##Goal

The goal of this repository is to output a CSV with the locations and known unit counts of deed restricted affordable housing units from a number of available data sources. 

##Data Sources

Data sources on deed restricted affordable housing the bay area area listed in data_sources.json

##Methods

1. Conform each source to the same schema (`conform.py`)
2. Geocode full addresses for which there are no latitude and longitude in the source (`geocode.py`)
3. Deduplicate records (`cluster.py`)
4. Summarize overlap (`summarize.py`)
5. Output chosen records with location and unit based on a heuristic (`get_units.py`)
6. Using the scripts in `ahs/`, check the output results against those in the American Housing Survey
7. Join the point-based unit counts to parcels using the `get_nearest_parcel.sql` script.

##Result

The result, a CSV file, is issued at a pull request for modeling [here](https://github.com/MetropolitanTransportationCommission/bayarea_urbansim/pull/38)

##Thanks

Thanks to Pedro Galvao, Nathaniel Decker, Max Gardener, and Michael Reilly for their invaluable data and input in developing a method for developing this list. 
