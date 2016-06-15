from __future__ import division
import json
import pandas as pd
import itertools as it

with open('data_sources.json') as data_file:    
	data = json.load(data_file)

def summarize(data_sources):
	d = {}
	for source in data_sources:
		df = pd.read_csv(source['url'])
		units = df[source['units_column']].sum()
		records = len(df)
		d[source['shortname']] = {
		    'units' : units,
		    'records' : records
		}
	return d

d = summarize(data)
summary_df = pd.DataFrame(d)
print summary_df
#summarize clusters

df = pd.read_csv('clustered.csv')

s = df['Cluster ID'].value_counts() > 1
s1 = df['Cluster ID'].isin(s.index)
df_d = df.loc[s1.index,:]

#check the overlap among all data types
sets = df_d.groupby('Cluster ID')['shortname'].aggregate(lambda ts: frozenset(ts))
print sets.value_counts()
