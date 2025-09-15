#!/usr/bin/env python3
import json, os, sys, glob
BASE = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

ISSUES = []

# Validate items
for p in sorted(glob.glob(os.path.join(BASE, 'data', '*.json'))):
    bn = os.path.basename(p)
    if bn == 'index.json':
        continue
    try:
        data = json.load(open(p))
    except Exception as e:
        ISSUES.append((bn, f'Parse error: {e}'))
        continue
    if not isinstance(data, list):
        ISSUES.append((bn, 'Top-level is not a list'))
        continue
    for i, item in enumerate(data):
        where = f'{bn}[{i}]'
        for k in ('id','name','media','meta','tags','accessibility','slug'):
            if k not in item:
                ISSUES.append((where, f'Missing key: {k}'))
        # locales
        for objk in ('name',):
            obj = item.get(objk) or {}
            for lang in ('en','hi','gu'):
                if lang not in obj:
                    ISSUES.append((where, f'Missing {objk}.{lang}'))
        alt = ((item.get('accessibility') or {}).get('altText')) or {}
        for lang in ('en','hi','gu'):
            if lang not in alt:
                ISSUES.append((where, f'Missing accessibility.altText.{lang}'))
        img = ((item.get('media') or {}).get('image'))
        if not img:
            ISSUES.append((where, 'Missing media.image'))
        else:
            ip = os.path.join(BASE, img)
            if not os.path.exists(ip):
                ISSUES.append((where, f'Image missing: {img}'))
        # order sequential
        order = ((item.get('meta') or {}).get('order'))
        if order != i+1:
            ISSUES.append((where, f'meta.order should be {i+1}, got {order}'))

# Validate index icons
try:
    idx = json.load(open(os.path.join(BASE, 'data', 'index.json')))
    for i, cat in enumerate(idx):
        icon = cat.get('icon')
        if icon and not os.path.exists(os.path.join(BASE, icon)):
            ISSUES.append((f'index[{i}]', f'Icon missing: {icon}'))
except Exception as e:
    ISSUES.append(('index.json', f'Parse error: {e}'))

if ISSUES:
    for where, msg in ISSUES:
        print(f'- {where}: {msg}')
    sys.exit(1)
else:
    print('Validation passed')
