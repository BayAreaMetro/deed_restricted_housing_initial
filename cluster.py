#!/usr/bin/python
# -*- coding: utf-8 -*-
"""
This is mostly clobbered together from 
github.com/datamade/dedupe-examples
in particular the 'patent example'
"""
from future.builtins import next

import os
import csv
import re
import logging
import optparse

import dedupe
from unidecode import unidecode

# ## Logging

# Dedupe uses Python logging to show or suppress verbose output. This
# code block lets you change the level of loggin on the command
# line. You don't need it if you don't want that. To enable verbose
# logging, run `python examples/csv_example/csv_example.py -v`
optp = optparse.OptionParser()
optp.add_option('-v', '--verbose', dest='verbose', action='count',
                help='Increase verbosity (specify multiple times for more)'
                )
(opts, args) = optp.parse_args()
log_level = logging.WARNING 
if opts.verbose:
    if opts.verbose == 1:
        log_level = logging.INFO
    elif opts.verbose >= 2:
        log_level = logging.DEBUG
logging.getLogger().setLevel(log_level)

# ## Setup

input_file = 'geocoded.csv'
output_file = 'clustered.csv'
settings_file = 'cluster_settings'
training_file = 'cluster_training.json'

def preProcess(column):
    """
    Do a little bit of data cleaning with the help of Unidecode and Regex.
    Things like casing, extra spaces, quotes and new lines can be ignored.
    """
    try : # python 2/3 string differences
        column = column.decode('utf8')
    except AttributeError:
        pass
    column = unidecode(column)
    column = re.sub('  +', ' ', column)
    column = re.sub('\n', ' ', column)
    column = column.strip().strip('"').strip("'").lower().strip()
    # If data is missing, indicate that by setting the value to `None`
    if not column:
        column = None
    return column

def readData(filename):
    """
    Read in our data from a CSV file and create a dictionary of records, 
    where the key is a unique record ID and each value is dict
    """
    data_d = {}
    with open(filename) as f:
        reader = csv.DictReader(f)
        for idx, row in enumerate(reader):
            row = dict((k, preProcess(v)) for k, v in row.items())
            if row['latitude'] == row['longitude'] == '0.0':
                row['latlong'] = None
            else :
                row['latlong'] = (float(row['latitude']), float(row['longitude']))
            row_id = idx
            data_d[row_id] = dict(row)

    return data_d

print('importing data ...')
data_d = readData(input_file)

# If a settings file already exists, we'll just load that and skip training
if os.path.exists(settings_file):
    print('reading from', settings_file)
    with open(settings_file, 'rb') as f:
        deduper = dedupe.StaticDedupe(f)
else:
    # ## Training

    # Define the fields dedupe will pay attention to
    fields = [
        {'field' : 'latlong', 'type': 'LatLong', 'has missing' : False},
        {'field' : 'full_address', 'type': 'ShortString', 'has missing' : True},
        {'field' : 'zip_code', 'type': 'Exact', 'has missing' : True},
        {'field' : 'city', 'type': 'String', 'has missing' : True},
        {'field' : 'county', 'type': 'String', 'has missing' : True},
        {'field' : 'shortname', 'type': 'ShortString', 'has missing' : False},
        {'field' : 'msa', 'type': 'ShortString', 'has missing' : True},
        {'field' : 'property_name', 'type': 'ShortString', 'has missing' : True},
        {'field' : 'smsa', 'type': 'ShortString', 'has missing' : True},
        {'field' : 'units', 'type': 'ShortString', 'has missing' : True},
        {'field' : 'street_suffix', 'type': 'ShortString', 'has missing' : True},
        {'field' : 'street_name', 'type': 'ShortString', 'has missing' : True},
        {'field' : 'apn', 'type': 'ShortString', 'has missing' : True},
        ]
    #import pdb; pdb.set_trace()
    # Create a new deduper object and pass our data model to it.
    deduper = dedupe.Dedupe(fields)

    # To train dedupe, we feed it a sample of records.
    deduper.sample(data_d, 1000)

    # If we have training data saved from a previous run of dedupe,
    # look for it and load it in.
    # __Note:__ if you want to train from scratch, delete the training_file
    if os.path.exists(training_file):
        print('reading labeled examples from ', training_file)
        with open(training_file, 'rb') as f:
            deduper.readTraining(f)

    # ## Active learning
    # Dedupe will find the next pair of records
    # it is least certain about and ask you to label them as duplicates
    # or not.
    # use 'y', 'n' and 'u' keys to flag duplicates
    # press 'f' when you are finished
    print('starting active labeling...')

    dedupe.consoleLabel(deduper)

    # Using the examples we just labeled, train the deduper and learn
    # blocking predicates
    deduper.train()

    # When finished, save our training to disk
    with open(training_file, 'w') as tf:
        deduper.writeTraining(tf)

    # Save our weights and predicates to disk.  If the settings file
    # exists, we will skip all the training and learning next time we run
    # this file.
    with open(settings_file, 'wb') as sf:
        deduper.writeSettings(sf)

#apparently the second argument is the recall weight
#to be played with a ratio between recall and precision
clustered_dupes = deduper.match(data_d, 0.3)

print('# duplicate sets', len(clustered_dupes))

# ## Writing Results

# Write our original data back out to a CSV with a new column called 
# 'Cluster ID' which indicates which records refer to each other.

cluster_membership = {}
cluster_id = 0
for cluster_id, (cluster, scores) in enumerate(clustered_dupes):
    for record_id, score in zip(cluster, scores):
        cluster_membership[record_id] = (cluster_id, score)

unique_id = cluster_id + 1

with open(output_file, 'w') as f_out, open(input_file) as f_in :
    writer = csv.writer(f_out)
    reader = csv.reader(f_in)

    heading_row = next(reader)
    heading_row.insert(0, 'Score')
    heading_row.insert(0, 'Cluster ID')
    writer.writerow(heading_row)

    for row_id, row in enumerate(reader):
        if row_id in cluster_membership:
            cluster_id, score = cluster_membership[row_id]
        else:
            cluster_id, score = unique_id, None
            unique_id += 1
        row.insert(0, score)
        row.insert(0, cluster_id)
        writer.writerow(row)