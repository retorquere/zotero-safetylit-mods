#!/usr/bin/env python3

import argparse
import json
from datetime import datetime
import re

parser = argparse.ArgumentParser(description='Process JSON header')
group = parser.add_mutually_exclusive_group(required=True)
group.add_argument('--merge', type=str, help='add header to JSON data')
group.add_argument('--split', type=str, help='remove header from JSON data')
args, translators = parser.parse_known_args()

for translator in translators:
  if args.merge:
    with open(args.merge) as f:
      header = json.load(f)
      header['translatorID'] = '011e23fd-91bd-4c3e-b1ae-edf22889d944'
      header['label'] = 'SafetyLit MODS'
      header['inRepository'] = False
      header['creator'] = 'Simon Kornblith, Richard Karnesky, Abe Jellinek and Emiliano Heyns'
      header['translatorType'] = 2
      header['lastUpdated'] = datetime.now().strftime("%Y-%m-%dT%H:%M:%S")
      header['displayOptions']['Export abstract'] = True
    with open(translator) as f:
      body = f.read()
    with open(translator, 'w') as f:
      f.write(json.dumps(header, indent='\t') + '\n' + body)

  if args.split:
    body = open(translator).read()
    match = re.search(r"(.*?\n}\n)(.*)", body, flags=re.DOTALL)
    header, body = match.groups()
    with open(args.split, 'w') as f:
      f.write(header)
    with open(translator, 'w') as f:
      f.write(body)
