import pandas as pd

df = pd.read_csv('clustered.csv')

#clean up the units column
#it contains messy data, coerce to numeric
df.units = df.units.convert_objects(convert_numeric=True)

grouped = df.groupby('Cluster ID')

#first check: are there more than 2 values for units?
#second: how many are there?
counter = 0 
exact_counter = 0

df_sample = df.loc[grouped.groups[0],:]
multiple_df = pd.DataFrame(columns=df_sample.columns)
exact_df = pd.DataFrame(columns=df_sample.columns)

for name, group in grouped:
	df2 = group
	vc = df2.units.value_counts().values
	if len(df2.units.value_counts()) > 1:
		counter += len(vc)
		multiple_df = multiple_df.append(df2)
		if True in [i > 1 for i in vc]:
			exact_counter += 1
			exact_df = exact_df.append(df2)
		else:
			next
	else:
		next

print "There are {} records with multiple units counts".format(counter)
print "There are {} clusters with at least 1 equal unit count".format(exact_counter)

#optional flags to inspect unit counts where there are multiple
#in the future, it would be good to come up with
#a better heuristic, but at cursory review (based on looking at ~20 properties), the maximum
#unit number found seems to be the closest to the actual value
#multiple_df.to_csv('multiple_units.csv')
#exact_df.to_csv('exact_same_unit_count.csv')

df = df.sort('units', ascending=False).groupby('Cluster ID', as_index=False).first()

df.to_csv('full_selected_cluster_results.csv')

df.to_csv('deed_restricted_units_by_location.csv',  columns=['Cluster ID','index','latitude','longitude','units'])

#fourth: review cases by hand in which there are more than 1 value for units

