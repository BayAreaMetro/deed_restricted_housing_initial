from __future__ import division
import pandas as pd
import itertools as it

filename = 'conformed.csv'
df = pd.read_csv(filename)

df.address = df.address.str.replace("\r", "")

dft = df[df.latitude.isnull() & ~df.full_address.isnull()]

import geocoder
f = open('../keys/bing')
bkey = f.read().splitlines()[0]

def geocode_df_row(row):
    try:
        g1 = geocoder.bing(row.full_address, key=bkey)
        return pd.Series([g1.latlng[0], g1.latlng[1]], index=['latitude','longitude'])
    except:
        pass

df.loc[dft.index,['latitude','longitude']] = dft.apply(geocode_df_row, axis=1)

df_ll = df[~df.latitude.isnull()]

df_ll['latlong'] = zip(df_ll['latitude'],df_ll['longitude'])

#write out 2 csvs, one with lat/longs only
df_ll.to_csv('geocoded.csv')

#the other with all values
df.to_csv('geocoded_with_empty.csv')