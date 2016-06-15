import json
import pandas as pd

with open('data_sources.json') as data_file:    
    data_sources = json.load(data_file)

#create an empty generic data frame
df_columns = ['street_number','street_name','street_suffix','city',
              'zip_code','apn','full_address','latitude','longitude',
              'smsa','msa','cbsa','property_name','shortname',
              'address','county','units','latlong']

dtype_g =    ['float','street_name','street_suffix','city',
              'zip_code','apn','full_address','latitude','longitude',
              'smsa','msa','cbsa','property_name',
              'address','county','units','latlong']


def read_normalized_csv(path):
    df = pd.read_csv(path)
    df.columns = [x.lower() for x in list(df.columns)]
    df = remove_unnammed_columns(df)
    return df

def remove_unnammed_columns(df):
    for col in df.columns:
        if 'Unnamed' in col:
            del df[col]
    return df

def map_to_generic(data_source):
    df_s = read_normalized_csv(data_source['url'])
    df_g = pd.DataFrame(columns=df_columns, index=df_s.index)
    df_g[data_source['column_map']['column_type']] = df_s[data_source['column_map']['column_name']]
    df_g["shortname"] = data_source['shortname']
    df_g["source_index"] = df_g.index
    return df_g

generic_df = pd.DataFrame(columns=df_columns)

for data_source in data_sources:
    df1 = map_to_generic(data_source)
    generic_df = generic_df.append(df1)

new_index=range(0,len(generic_df))
generic_df['index']=new_index
generic_df=generic_df.set_index('index')

#because we read directly to multiple pandas
#dataframes, and values are coerced to various types
def string_hack(avalue):
    if pd.isnull(avalue):
        stringvalue = ""
    elif type(avalue)==float:
        stringvalue = '%.0f' % avalue 
    else:
        stringvalue = str(avalue)
    return stringvalue

# concatenate address field for those missing full
def concatenate_address_fields(df_row):
    if pd.isnull(df_row['street_number']):
        street = string_hack(df_row['address'])
    else:
        street = string_hack(df_row['street_number'])
    df_row['full_address'] = street + " " \
    + string_hack(df_row['street_name']) + " " \
    + string_hack(df_row['street_suffix']) + ", " \
    + string_hack(df_row['city']) + ", CA " \
    + string_hack(df_row['zip_code'])
    return df_row

nlad = generic_df['full_address'].isnull()

generic_df.loc[nlad,:] = generic_df.loc[nlad,:].apply(concatenate_address_fields, axis='columns')

generic_df.full_address = generic_df.full_address.str.replace("\r", "")

generic_df.to_csv('conformed.csv')