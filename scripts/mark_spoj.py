#!/usr/bin/env python3

from argparse import ArgumentParser
from collections import namedtuple

import csv
import math
import sys

argparser = ArgumentParser(description='''\
This script takes a SPOJ log of submissions and produces marks.

To obtain a SPOJ log, select a 'custom contest judge' and download its 'input'.
''')
argparser.add_argument('logpath',
    help='path to SPOJ log')
argparser.add_argument('markspath',
    help='path where to dump marks (in csv format)')

User = namedtuple('User', ['login', 'name'])
Submission = namedtuple('Submission', ['userid', 'problemid', 'score'])
Log = namedtuple('Log', ['problems', 'users', 'submissions'])

def parse_log(logpath):
  problems = {}
  users = {}
  submissions = []

  with open(logpath) as logfile:
    contest_info_line_count = int(logfile.readline())
    for _ in range(contest_info_line_count):
      logfile.readline()
    problem_count = int(logfile.readline())
    lines_per_problem = int(logfile.readline())
    for _ in range(problem_count):
      pid = int(logfile.readline())
      _timelimit = logfile.readline()
      pcode = logfile.readline().strip()
      for _ in range(3, lines_per_problem):
        _ = logfile.readline()
      problems[pid] = pcode
    user_count = int(logfile.readline())
    lines_per_user = int(logfile.readline())
    for _ in range(user_count):
      uid = int(logfile.readline())
      ulogin = logfile.readline().strip()
      uname = logfile.readline().strip()
      for _ in range(3, lines_per_user):
        _ = logfile.readline()
      users[uid] = User(ulogin, uname)
    series_count = int(logfile.readline())
    lines_per_submission = int(logfile.readline())
    for _ in range(series_count):
      _info = logfile.readline()
      submissions_count = int(logfile.readline())
      for _ in range(submissions_count):
        uid = int(logfile.readline())
        pid = int(logfile.readline())
        _date = logfile.readline()
        _status = logfile.readline()
        _language = logfile.readline()
        score = float(logfile.readline())
        _time = logfile.readline()
        _date = logfile.readline()
        for _ in range(8, lines_per_submission):
          _ = logfile.readline()
        submissions.append(Submission(uid, pid, score))
  return Log(problems, users, submissions)

def compute_scores(log):
  scores = { u : { p : 0.0 for p in log.problems.keys() } for u in log.users.keys() }
  for s in log.submissions:
    if s.userid not in scores:
      sys.stderr.write('W: user id not found: {}\n'.format(s.userid))
    elif s.problemid not in scores[s.userid]:
      sys.stderr.write('W: problem id not found: {}\n'.format(s.problemid))
    else:
      scores[s.userid][s.problemid] = max(scores[s.userid][s.problemid], s.score)
  score_per_user = {}
  for u in log.users.keys():
    score_per_user[u] = math.ceil(0.01 * sum(scores[u][p] for p in log.problems.keys()))
  return score_per_user

def report_scores(users, scores, markspath):
  with open(markspath, 'w', newline='') as marksfile:
    fieldnames=['login','name','score']
    writer = csv.DictWriter(marksfile, dialect=csv.excel, fieldnames=fieldnames)
    writer.writeheader()
    for uid, s in scores.items():
      writer.writerow({'login':users[uid].login, 'name':users[uid].name, 'score':s})

def main():
  args = argparser.parse_args()
  log = parse_log(args.logpath)
  scores = compute_scores(log)
  report_scores(log.users, scores, args.markspath)

if __name__ == '__main__':
  main()
