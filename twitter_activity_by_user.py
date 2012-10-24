import sys, string, json

for line in sys.stdin:
  json_string = string.strip(line)
  if not json_string:
    continue
  
  tweet = json.loads(line)
  screen_name = tweet['user']['screen_name']
  print "LongValueSum:%s\t%s"%(screen_name, 1)